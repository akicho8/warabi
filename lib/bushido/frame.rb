# -*- coding: utf-8 -*-
#
# 全体管理
#
module Bushido
  module PlayerSelector
    extend ActiveSupport::Concern

    included do
      attr_reader :players, :counter
    end

    module ClassMethods
      # 先手後手が座った状態で開始
      def start
        new.tap do |o|
          Location.each{|loc|
            player = Player.new(:location => loc)
            player.deal
            o.player_join(player)
          }
        end
      end
    end

    def initialize
      super
      @players = []
      @counter = 0
    end

    def player_join(player)
      @players << player
      player.frame = self
      player.board = @board
    end

    def player_at(location)
      @players[Location[location].index]
    end

    # 前後のプレイヤーを返す
    def prev_player; current_player(-1); end
    def next_player; current_player(+1); end

    # 手番のプレイヤー
    def current_player(diff = 0)
      players[current_index(diff)]
    end

    def current_index(diff = 0)
      (@counter + diff).modulo(@players.size)
    end

    # プレイヤーたちの持駒から平手用の盤面の準備
    def piece_plot
      @players.collect(&:piece_plot)
    end

    # プレイヤーたちの持駒を捨てる
    def piece_discard
      @players.collect(&:piece_discard)
    end

    # def deal
    #   @players.each(&:deal)
    # end

    # N手目のN
    def counter_human_name
      @counter.next
    end
  end

  module Boardable
    extend ActiveSupport::Concern

    included do
      attr_reader :board
    end

    module ClassMethods
    end

    def initialize
      super
      @board = Board.new
    end

    # TODO: 「香落ち」対応。香落ちなどは先手と決まっている
    def board_reset(value)
      if value.blank? || value == :default || value == "平手"
        hash = Location.inject({}){|hash, v|hash.merge(v => Utils.initial_placements_for(v))}
      elsif Array === value
        hash = value.inject({}){|hash, v|hash.merge(v => Utils.initial_placements_for(v))}
      else
        hash = BaseFormat.board_parse(value)
      end
      hash.each{|k, v|
        player_at(k).initial_soldiers(v, :from_piece => false)
      }
    end
  end

  module Serialization
    # TODO: Player の marshal_dump が使われてない件について調べる
    def marshal_dump
      {
        :counter         => @counter,
        :players         => @players,
        :simple_kif_logs => @simple_kif_logs,
        :human_kif_logs => @human_kif_logs,
        :point_logs      => @point_logs,
      }
    end

    def marshal_load(attrs)
      @counter      = attrs[:counter]
      @players    = attrs[:players]
      @simple_kif_logs   = attrs[:simple_kif_logs]
      @human_kif_logs   = attrs[:human_kif_logs]
      @point_logs = attrs[:point_logs]
      @board = Board.new
      @players.each{|player|
        player.board = @board
        player.frame = self
      }
      @players.collect{|player|
        player.render_soldiers
      }
    end

    def deep_dup
      Marshal.load(Marshal.dump(self))
    end

    # サンドボックス実行用
    def sandbox_for(&block)
      stack_push
      begin
        if block_given?
          yield self
        end
      ensure
        stack_pop
      end
    end
  end

  module HistoryStack
    def initialize(*)
      super
      @stack = []
    end

    def stack_push
      @stack.push(deep_dup)
    end

    def stack_pop
      if @stack.empty?
        raise HistroyStackEmpty
      end
      marshal_load(@stack.pop.marshal_dump)
    end
  end

  module Executer
    extend ActiveSupport::Concern

    included do
      attr_reader :counter, :simple_kif_logs, :human_kif_logs, :point_logs
    end

    module ClassMethods
      def testcase3(params = {})
        params = {
          :nplayers => 2,
        }.merge(params)

        object = new
        params[:nplayers].times do |i|
          player = Player.new
          player.location = Location[i]
          player.deal
          object.player_join(player)
        end
        (params[:init] || []).each_with_index{|init, index|object.current_player(index).initial_soldiers(init)}
        object.execute(params[:exec])
        object
      end
    end

    def initialize(*)
      super
      @point_logs = []
      @simple_kif_logs = []
      @human_kif_logs = []
    end

    # 棋譜入力
    def execute(str)
      Array.wrap(str).each do |str|
        if str == "投了"
          return
        end
        current_player.execute(str)
        log_stock(current_player)
        @counter += 1
      end
    end

    # player.execute の直後に呼んで保存する
    def log_stock(player)
      @point_logs << player.parsed_info.point
      @simple_kif_logs << "#{player.location.mark}#{player.parsed_info.last_kif}"
      @human_kif_logs << "#{player.location.mark}#{player.parsed_info.last_ki2}"
    end

    def inspect
      "#{counter_human_name}手目: #{current_player.location.mark_with_name}番\n#{super}"
    end

    def to_s
      s = ""
      s << @board.to_s
      s << @players.collect{|player|"#{player.location.mark_with_name}の持駒:#{player.to_s_pieces}"}.join("\n") + "\n"
      s
    end
  end

  class BasicFrame
    include PlayerSelector
    include Boardable
    include Executer
    include Serialization
    include HistoryStack
  end

  class Frame < BasicFrame
  end

  class LiveFrame < Frame
  end

  class SimulatorFrame < LiveFrame
    def initialize(pattern)
      super()
      @pattern = pattern

      Location.each{|loc|
        player_join(Player.new(:location => loc))
      }

      board_reset(@pattern[:board])

      if @pattern[:pieces]
        Location.each{|loc|
          players[loc.index].deal(@pattern[:pieces][loc.key])
        }
      end
    end

    def to_all_frames(&block)
      frames = []
      frames << deep_dup
      if block
        yield frames.last
      end
      Utils.ki2_input_seq_parse(@pattern[:execute]).each{|op|
        if op == "push"
          stack_push
        elsif op == "pop"
          stack_pop
        else
          player = players[Location[op[:location]].index]
          player.execute(op[:input])
          log_stock(player)
          frames << deep_dup
          if block
            yield frames.last
          end
        end
      }
      frames
    end
  end

  # FIXME: pattern をこの中に入れたらどうなる？
  class Sequencer < LiveFrame
    attr_reader :frames, :variables
    attr_accessor :pattern

    def initialize(pattern = nil)
      super()
      @pattern = pattern
      @frames = []
      @variables = {}
      @instruction_pointer = 0

      Location.each{|loc|
        player_join(Player.new(:location => loc))
      }
    end

    def set(key, value)
      @variables[key] = value
    end

    def get(key)
      @variables[key]
    end

    def marshal_dump
      super.merge(:variables => @variables)
    end

    def marshal_load(attrs)
      super
      @variables = attrs[:variables]
    end

    def evaluate
      @pattern.evaluate(self)
    end

    def eval_step
      loop do
        expr = @pattern.seqs[@instruction_pointer]
        @instruction_pointer += 1
        unless expr
          break
        end
        expr.evaluate(self)
        if KifuDsl::Mov === expr
          break
        end
      end
    end
  end
end
