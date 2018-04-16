# 手を返せるようにした実用版(リファクタリング前)

require 'active_support/core_ext/benchmark'
require "./reversi_app"
require "timeout"

class DirtyMinimax
  attr_accessor :mediator
  attr_accessor :params
  attr_accessor :current_turn
  attr_accessor :out_of_time

  def initialize(**params)
    self.params.update(params)

    @out_of_time = nil
  end

  def params
    @params ||= {
      times: 256,
      depth_max: 3,
      dimension: 4,
      depth_range: nil,
      time_limit: nil,          # 制限なし
    }
  end

  def run
    @mediator = ReversiApp.new(params)

    params[:times].times do |turn|
      @current_turn = turn
      player = mediator.player_at(turn)

      start_time = Time.now
      if params[:depth_range]
        infos = interactive_deepning(turn)
      else
        infos = fast_score_list(turn)
      end
      time = Time.now - start_time

      if infos.empty?
        # 手がないときはここでパスする
        mediator.pass_count += 1
      else
        if best = infos.first
          hand = best[:hand]
          if hand == :pass
            raise "must not happen"
            mediator.pass_count += 1
          else
            mediator.place_on(player, hand)
            mediator.pass_count = 0
          end
        end
      end

      unless params[:silent]
        puts "#{'-' * 60} [#{turn}] #{player} 実行速度:#{time}".strip
        puts mediator
        if infos.empty?
          puts "(pass)"
        end

        rows = infos.collect.with_index do |e, i|
          {
            "順位"   => i.next,
            "候補手" => e[:hand].to_a,
            "読み筋" => e[:forecast].collect { |e| e == :pass ? "PASS" : e.to_a.to_s }.join(" "),
            "評価値" => e[:score],
            "形勢"   => player == :o ? e[:score] : -e[:score], # 表示は常に先手からの評価にしておく
            "時間"   => e[:sec],
          }
        end
        tp rows
      end

      if mediator.continuous_pass?
        unless params[:silent]
          puts "連続パスで終了"
        end
        break
      end

      if mediator.game_over?
        break
      end
    end
    unless params[:silent]
      tp mediator.histogram
    end
    mediator.histogram
  end

  def fast_score_list(turn)
    player = mediator.player_at(turn)

    infos = mediator.available_places(player).collect do |e|
      mediator.place_on(player, e) do
        v, pv = compute_score(turn: turn + 1, depth_max: params[:depth_max])
        v = -v
        {hand: e, forecast: pv, score: v, score2: player == :o ? v : -v}
      end
    end
    infos.sort_by { |e| -e[:score] }
  end

  def interactive_deepning(turn)
    player = mediator.player_at(turn)

    @out_of_time = nil
    if v = params[:time_limit]
      @out_of_time = Time.now + v
    end

    infos = []
    all_finished = catch @out_of_time do
      params[:depth_range].each do |depth_max|
        infos = mediator.available_places(player).collect do |e|
          mediator.place_on(player, e) do
            start_time = Time.now
            v, pv = compute_score(turn: turn + 1, depth_max: depth_max)
            v = -v
            {hand: e, forecast: pv, score: v, score2: player == :o ? v : -v, sec: Time.now - start_time}
          end
        end
      end
      true
    end

    if infos.empty?
      unless mediator.available_places(player).empty?
        puts "指し手があるのにパスすることになってしまいます。制限時間を増やすか読みを浅くしてください。"
      end
    end

    infos.sort_by { |e| -e[:score] }
  end

  def perform_out_of_time_check
    if @out_of_time
      if @out_of_time < Time.now
        throw @out_of_time
      end
    end
  end

  def compute_score(turn:, depth_max:)
    v, pv = primitive_mini_max(turn: turn, depth_max: depth_max)

    # Negamax を想定しているため後手番なら符号を逆にする(後手から見て有利な状況は、よりマイナスではなく、よりプラスであるとする)
    player = mediator.player_at(turn)
    if player == :x
      v = -v
    end

    [v, pv]
  end

  def primitive_mini_max(turn:, depth_max:, depth: 0)
    perform_out_of_time_check   # 深さ6ぐらいになると一手で数秒かかるためここに入れた方がいい

    # 一番深い局面に達したらはじめて評価する
    if depth_max <= depth
      return [mediator.evaluate(:o), []] # 常に「先手から」の評価値
    end

    # 合法手がない場合はパスして相手に手番を渡す
    player = mediator.player_at(turn)
    children = mediator.available_places(player)

    if children.empty?
      v, pv = primitive_mini_max(turn: turn + 1, depth_max: depth_max, depth: depth + 1)
      return [v, [:pass, *pv]]
    end

    forecast = []
    if turn.even?
      # 自分が自分にとってもっとも有利な手を探す
      max = -Float::INFINITY
      children.each do |place|
        mediator.place_on(player, place) do
          v, pv = primitive_mini_max(turn: turn + 1, depth_max: depth_max, depth: depth + 1)
          if v > max
            forecast = [place, *pv]
            max = v
          end
        end
      end

      [max, forecast]
    else
      # 相手が自分にとってもっとも不利な手を探す
      min = Float::INFINITY
      children.each do |place|
        mediator.place_on(player, place) do
          v, pv = primitive_mini_max(turn: turn + 1, depth_max: depth_max, depth: depth + 1)
          if v < min
            forecast = [place, *pv]
            min = v
          end
        end
      end
      [min, forecast]
    end
  end
end

if $0 == __FILE__
  # DirtyMinimax.new.run          # => {:o=>1, :x=>10}
  # DirtyMinimax.new(times: 2, dimension: 4, depth_max: 3).run                           # => {:o=>3, :x=>3}
  # DirtyMinimax.new(times: 2, dimension: 4, depth_range: 3..3, time_limit: 0.5).run # => {:o=>3, :x=>3}
  # DirtyMinimax.new(times: 1, dimension: 6, depth_range: 1..8, time_limit: 1.0).run # => {:o=>4, :x=>1}
  DirtyMinimax.new(times: 1, dimension: 6, depth_range: 0..7, time_limit: 1.0).run # => {:o=>4, :x=>1}
end
# >> ------------------------------------------------------------ [0] o 実行速度:1.000247
# >> ・・・・・・
# >> ・・○・・・
# >> ・・○○・・
# >> ・・○×・・
# >> ・・・・・・
# >> ・・・・・・
# >> |------+--------+-----------------------------+--------+----------|
# >> | 順位 | 候補手 | 読み筋                      | 評価値 | 時間     |
# >> |------+--------+-----------------------------+--------+----------|
# >> |    1 | [2, 1] | [1, 1] [0, 1] [0, 0] [1, 2] |      3 | 0.089578 |
# >> |    2 | [1, 2] | [1, 1] [1, 0] [0, 0] [2, 1] |      3 | 0.095365 |
# >> |    3 | [4, 3] | [2, 4] [1, 1] [2, 1] [1, 0] |      3 | 0.090193 |
# >> |    4 | [3, 4] | [4, 2] [1, 1] [1, 2] [0, 1] |      3 | 0.088944 |
# >> |------+--------+-----------------------------+--------+----------|
# >> |---+---|
# >> | o | 4 |
# >> | x | 1 |
# >> |---+---|
