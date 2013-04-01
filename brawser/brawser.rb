# -*- coding: utf-8 -*-
# WEBインタフェース

require "bundler"
Bundler.require(:default, :webif)

# require "bushido"
# require "sinatra/base"
# require "sinatra/reloader"
# require "uri"
# require "redis"
# require "sass"
# require "haml"
# require "compass"
require "bushido/contrib/effective_patterns"

class MediatorDecorator < SimpleDelegator
  def to_html_board(type = :default)
    rows = Bushido::Position::Vpos.ridge_length.times.collect do |y|
      tds = Bushido::Position::Hpos.ridge_length.times.collect do |x|
        tag_class = []
        cell = ""
        if soldier = board.surface[[x, y]]
          tag_class << soldier.player.location.key
          cell = soldier.piece_current_name
        end
        if kif_log = kif_logs.last
          if kif_log.point == Bushido::Point[[x, y]]
            tag_class << "last_point"
          end
          if kif_log.origin_point == Bushido::Point[[x, y]]
            tag_class << "last_point2"
          end
        end
        "<td class=\"#{tag_class.join(' ')}\">#{cell}</td>"
      end
      "<tr>#{tds.join("\n")}</tr>"
    end
    "<table class=\"board #{type}\">\n#{rows.join("\n")}\n</table>"
  end
end

redis_args = {}
if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  redis_args = {:host => uri.host, :port => uri.port, :password => uri.password}
end
REDIS = Redis.new(redis_args)
REDIS.flushdb

class Brawser < Sinatra::Base
  register Sinatra::MultiRoute

  configure :development do
    register Sinatra::Reloader
  end

  configure :production do
    set :server, :puma
  end

  set :sessions, true

  get "/stylesheet.css" do
    # FIXME: cache
    sass :stylesheet, Compass.sass_engine_options
  end

  get "/slim" do
    slim :slim_index
  end

  route :get, :post, "/" do
    @session_id = env["rack.session"]["session_id"]

    if !params[:reset].nil? || REDIS.get(@session_id).nil?
      mediator = Bushido::Mediator.start
      mediator.piece_plot
      REDIS.set(@session_id, Marshal.dump(mediator))
    end

    dump = Marshal.load(REDIS.get(@session_id))
    @mediator = Bushido::Mediator.from_dump(dump)

    if params[:location].nil? || @mediator.current_player.location.key.to_s == params[:location]
      if params[:way].present?
        @mediator.execute(params[:way])
      end
      if params[:auto1].present?
        eval_list = @mediator.current_player.brain.eval_list
        if info = eval_list.first
          @mediator.execute(info[:way])
        end
      end
      if params[:auto2].present?
        if way = @mediator.current_player.generate_way.presence
          @mediator.execute(way)
        end
      end
    end

    REDIS.set(@session_id, Marshal.dump(@mediator))

    haml :show
  end

  get "/effective_patterns" do
    if params[:id]
      @pattern = Bushido::EffectivePatterns[params[:id].to_i]
    end
    if @pattern
      if @pattern[:dsl]
        mediator = Bushido::Sequencer.new
        mediator.pattern = @pattern[:dsl]
        mediator.evaluate
        @frames = mediator.frames
      else
        mediator = Bushido::SimulatorFrame.new(@pattern)
        @frames = mediator.build_frames
      end
    end
    haml :effective_patterns
  end

  get "/board_points" do
    session[:test_count] ||= 0
    session[:start_time] ||= Time.now
    unless params[:count]
      session[:test_count] = 0
      session[:start_time] = Time.now
    end
    count = params[:count].to_i
    session[:test_count] += count
    begin
      @mediator = Bushido::Mediator.start
      count.times do
        mini_soldier = MiniSoldier[:point => Bushido::Point.to_a.sample, :piece => Bushido::Piece.to_a.sample, :promoted => [true, false].sample]
        @mediator.players.sample.initial_soldiers(mini_soldier, :from_piece => false)
      end
    rescue Bushido::NotPutInPlaceNotBeMoved, Bushido::NotPromotable, Bushido::PieceAlredyExist => error
      retry
    end
    haml :board_points
  end

  error do
    @error = env["sinatra.error"]
    haml :show
  end
end
