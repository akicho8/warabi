# 手を返せるようにした実用版(リファクタリング前)

require "./reversi_app"
require "timeout"

class DirtyMinimax
  attr_accessor :app
  attr_accessor :params
  attr_accessor :current_turn

  def initialize(**params)
    self.params.update(params)
  end

  def params
    @params ||= {
      times: 256,
      depth_max: 3,
      dimension: 4,
      depth_max_range: nil,
      time_limit: nil,          # 制限なし
    }
  end

  def run
    @app = ReversiApp.new(params)

    params[:times].times do |turn|
      @current_turn = turn
      player = app.player_at(turn)

      start_time = Time.now
      if params[:depth_max_range]
        infos = deepen_score_list(turn)
      else
        infos = fast_score_list(turn)
      end
      time = Time.now - start_time

      if infos.empty?
        # 手がないときはここでパスする
        app.pass_count += 1
      else
        if best = infos.first
          hand = best[:hand]
          if hand == :pass
            raise "must not happen"
            app.pass_count += 1
          else
            app.put_on(player, hand)
            app.pass_count = 0
          end
        end
      end

      unless params[:silent]
        puts "#{'-' * 60} [#{turn}] #{player} 実行速度:#{time}".strip
        puts app
        if infos.empty?
          puts "(pass)"
        end

        rows = infos.collect.with_index do |e, i|
          {
            "順位"   => i.next,
            "候補手" => e[:hand].to_a,
            "読み筋" => e[:readout].collect { |e| e == :pass ? "PASS" : e.to_a.to_s }.join(" "),
            "評価値" => player == :o ? e[:score] : -e[:score], # 表示は常に先手からの評価にしておく
          }
        end
        tp rows
      end

      if app.continuous_pass?
        unless params[:silent]
          puts "連続パスで終了"
        end
        break
      end

      if app.game_over?
        break
      end
    end
    unless params[:silent]
      tp app.histogram
    end
    app.histogram
  end

  def fast_score_list(turn)
    player = app.player_at(turn)

    infos = app.can_put_points(player).collect do |e|
      app.put_on(player, e) do
        score, before_readout = compute_score(turn + 1, 0, params[:depth_max])
        {hand: e, readout: before_readout, score: -score}
      end
    end
    infos.sort_by { |e| -e[:score] }
  end

  def deepen_score_list(turn)
    player = app.player_at(turn)

    infos = []
    begin
      Timeout.timeout(params[:time_limit]) do
        params[:depth_max_range].each do |depth_max|
          infos = app.can_put_points(player).collect do |e|
            app.put_on(player, e) do
              score, readout = compute_score(turn + 1, 0, depth_max)
              {hand: e, readout: readout, score: -score}
            end
          end
        end
      end
    rescue Timeout::Error
      app.run_counts[:TLE] += 1
    end

    if infos.empty?
      unless app.can_put_points(player).empty?
        raise "指し手があるのにパスすることになってしまいます。制限時間を増やすか読みを浅くしてください。"
      end
    end

    infos.sort_by { |e| -e[:score] }
  end

  def compute_score(turn, depth, depth_max)
    score, readout = mini_max(turn, depth, depth_max)

    player = app.player_at(turn)
    if player == :x
      score = -score
    end

    [score, readout]
  end

  def mini_max(turn, depth, depth_max)
    # 一番深い局面に達したらはじめて評価する
    if depth >= depth_max
      return [app.evaluate(:o), []] # 常に「先手から」の評価値
    end

    # 合法手がない場合はパスして相手に手番を渡す
    player = app.player_at(turn)
    children = app.can_put_points(player)

    if children.empty?
      score, readout = mini_max(turn + 1, depth + 1, depth_max)
      return [score, [:pass, *readout]]
    end

    readout = []
    if turn.even?
      # 自分が自分にとってもっとも有利な手を探す
      max = -Float::INFINITY
      children.each do |point|
        app.put_on(player, point) do
          score, before_readout = mini_max(turn + 1, depth + 1, depth_max)
          if score > max
            readout = [point, *before_readout]
            max = score
          end
        end
      end

      [max, readout]
    else
      # 相手が自分にとってもっとも不利な手を探す
      min = Float::INFINITY
      children.each do |point|
        app.put_on(player, point) do
          score, before_readout = mini_max(turn + 1, depth + 1, depth_max)
          if score < min
            readout = [point, *before_readout]
            min = score
          end
        end
      end
      [min, readout]
    end
  end
end

if $0 == __FILE__
  DirtyMinimax.new.run          # => {:o=>1, :x=>10}
  DirtyMinimax.new(times: 2, dimension: 4, depth_max: 3).run                           # => {:o=>3, :x=>3}
  DirtyMinimax.new(times: 2, dimension: 4, depth_max_range: 3..3, time_limit: 0.5).run # => {:o=>3, :x=>3}
  DirtyMinimax.new(times: 1, dimension: 6, depth_max_range: 1..8, time_limit: 1.0).run # => {:o=>4, :x=>1}
end
# >> ------------------------------------------------------------ [0] o 実行速度:0.045724
# >> ・○・・
# >> ・○○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [1, 0] | [0, 0] [3, 2] [2, 0] |      0 |
# >> |    2 | [0, 1] | [0, 0] [3, 2] [3, 1] |      0 |
# >> |    3 | [3, 2] | [1, 3] [0, 0] [1, 0] |      0 |
# >> |    4 | [2, 3] | [3, 1] [0, 0] [0, 1] |      0 |
# >> |------+--------+----------------------+--------|
# >> ------------------------------------------------------------ [1] x 実行速度:0.024456
# >> ×○・・
# >> ・×○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [0, 0] | [3, 2] [2, 0] [0, 1] |      3 |
# >> |    2 | [0, 2] | [0, 3] [2, 0] [3, 0] |      3 |
# >> |    3 | [2, 0] | [3, 0] [0, 0] [0, 1] |      5 |
# >> |------+--------+----------------------+--------|
# >> ------------------------------------------------------------ [2] o 実行速度:0.019323
# >> ×○・・
# >> ・×○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [3, 2] | [2, 0] [0, 1] [0, 2] |     -2 |
# >> |    2 | [2, 3] | [2, 0] [0, 1] [0, 2] |     -2 |
# >> |    3 | [0, 1] | [2, 0] [3, 2] [0, 2] |     -4 |
# >> |------+--------+----------------------+--------|
# >> ------------------------------------------------------------ [3] x 実行速度:0.016749
# >> ×××・
# >> ・×○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [2, 0] | [0, 1] [0, 2] PASS   |     -2 |
# >> |    2 | [3, 3] | [0, 1] [2, 0] [3, 0] |      1 |
# >> |    3 | [1, 3] | [0, 1] [2, 0] [0, 2] |      3 |
# >> |    4 | [3, 1] | [3, 0] [2, 0] [0, 1] |      5 |
# >> |------+--------+----------------------+--------|
# >> ------------------------------------------------------------ [4] o 実行速度:0.006841
# >> ×××・
# >> ○○○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+--------------------+--------|
# >> | 順位 | 候補手 | 読み筋             | 評価値 |
# >> |------+--------+--------------------+--------|
# >> |    1 | [0, 1] | [0, 2] PASS [2, 3] |     -9 |
# >> |------+--------+--------------------+--------|
# >> ------------------------------------------------------------ [5] x 実行速度:0.013154
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [0, 2] | PASS [2, 3] PASS     |     -9 |
# >> |    2 | [3, 3] | [2, 3] [0, 2] PASS   |     -2 |
# >> |    3 | [2, 3] | [3, 3] [0, 2] [3, 0] |     -1 |
# >> |    4 | [1, 3] | [0, 3] [3, 1] [3, 0] |      1 |
# >> |------+--------+----------------------+--------|
# >> ------------------------------------------------------------ [6] o 実行速度:0.000285
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> (pass)
# >> ------------------------------------------------------------ [7] x 実行速度:0.005483
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [2, 3] | PASS PASS PASS       |     -9 |
# >> |    2 | [1, 3] | [0, 3] [2, 3] [3, 0] |     -4 |
# >> |    3 | [3, 3] | [2, 3] [3, 1] [3, 0] |     -4 |
# >> |    4 | [3, 1] | [3, 0] [2, 3] [0, 3] |     -2 |
# >> |------+--------+----------------------+--------|
# >> ------------------------------------------------------------ [8] o 実行速度:0.000297
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> (pass)
# >> ------------------------------------------------------------ [9] x 実行速度:0.000203
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> (pass)
# >> 連続パスで終了
# >> |---+----|
# >> | o | 1  |
# >> | x | 10 |
# >> |---+----|
# >> ------------------------------------------------------------ [0] o 実行速度:0.035168
# >> ・○・・
# >> ・○○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [1, 0] | [0, 0] [3, 2] [2, 0] |      0 |
# >> |    2 | [0, 1] | [0, 0] [3, 2] [3, 1] |      0 |
# >> |    3 | [3, 2] | [1, 3] [0, 0] [1, 0] |      0 |
# >> |    4 | [2, 3] | [3, 1] [0, 0] [0, 1] |      0 |
# >> |------+--------+----------------------+--------|
# >> ------------------------------------------------------------ [1] x 実行速度:0.024429
# >> ×○・・
# >> ・×○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [0, 0] | [3, 2] [2, 0] [0, 1] |      3 |
# >> |    2 | [0, 2] | [0, 3] [2, 0] [3, 0] |      3 |
# >> |    3 | [2, 0] | [3, 0] [0, 0] [0, 1] |      5 |
# >> |------+--------+----------------------+--------|
# >> |---+---|
# >> | o | 3 |
# >> | x | 3 |
# >> |---+---|
# >> ------------------------------------------------------------ [0] o 実行速度:0.035641
# >> ・○・・
# >> ・○○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [1, 0] | [0, 0] [3, 2] [2, 0] |      0 |
# >> |    2 | [0, 1] | [0, 0] [3, 2] [3, 1] |      0 |
# >> |    3 | [3, 2] | [1, 3] [0, 0] [1, 0] |      0 |
# >> |    4 | [2, 3] | [3, 1] [0, 0] [0, 1] |      0 |
# >> |------+--------+----------------------+--------|
# >> ------------------------------------------------------------ [1] x 実行速度:0.025922
# >> ×○・・
# >> ・×○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 |
# >> |------+--------+----------------------+--------|
# >> |    1 | [0, 0] | [3, 2] [2, 0] [0, 1] |      3 |
# >> |    2 | [0, 2] | [0, 3] [2, 0] [3, 0] |      3 |
# >> |    3 | [2, 0] | [3, 0] [0, 0] [0, 1] |      5 |
# >> |------+--------+----------------------+--------|
# >> |---+---|
# >> | o | 3 |
# >> | x | 3 |
# >> |---+---|
# >> ------------------------------------------------------------ [0] o 実行速度:1.041951
# >> ・・・・・・
# >> ・・○・・・
# >> ・・○○・・
# >> ・・○×・・
# >> ・・・・・・
# >> ・・・・・・
# >> |------+--------+-----------------------------+--------|
# >> | 順位 | 候補手 | 読み筋                      | 評価値 |
# >> |------+--------+-----------------------------+--------|
# >> |    1 | [2, 1] | [1, 1] [0, 1] [0, 0] [1, 2] |      3 |
# >> |    2 | [1, 2] | [1, 1] [1, 0] [0, 0] [2, 1] |      3 |
# >> |    3 | [4, 3] | [2, 4] [1, 1] [2, 1] [1, 0] |      3 |
# >> |    4 | [3, 4] | [4, 2] [1, 1] [1, 2] [0, 1] |      3 |
# >> |------+--------+-----------------------------+--------|
# >> |---+---|
# >> | o | 4 |
# >> | x | 1 |
# >> |---+---|
