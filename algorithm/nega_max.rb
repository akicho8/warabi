require "./minimax"

class NegaMax < Minimax
  def compute_score(*args)
    nega_max(*args)
  end

  def nega_max(turn:, depth_max:, depth: 0)
    perform_out_of_time_check

    player = mediator.player_at(turn)

    # 一番深い局面に達したらはじめて評価する
    if depth_max <= depth
      return [mediator.evaluate(player), []] # 現局面手番視点
    end

    # 合法手がない場合はパスして相手に手番を渡す
    children = mediator.available_places(player)
    if children.empty?
      v, pv = nega_max(turn: turn + 1, depth_max: depth_max, depth: depth + 1)
      return [-v, [:pass, *pv]]
    end

    max = -Float::INFINITY
    forecast = []

    children.each do |place|
      mediator.place_on(player, place) do
        v, pv = nega_max(turn: turn + 1, depth_max: depth_max, depth: depth + 1)
        v = -v # 相手の一番良い手は自分の一番悪い手としたいので符号を反転する
        if v > max
          forecast = [place, *pv]
          max = v
        end
      end
    end

    [max, forecast]
  end
end

if $0 == __FILE__
  NegaMax.new.run               # => {:o=>1, :x=>10}
end
# >> ------------------------------------------------------------ [0] o 実行速度:0.031493
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
# >> ------------------------------------------------------------ [1] x 実行速度:0.019574
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
# >> ------------------------------------------------------------ [2] o 実行速度:0.01544
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
# >> ------------------------------------------------------------ [3] x 実行速度:0.015193
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
# >> ------------------------------------------------------------ [4] o 実行速度:0.004821
# >> ×××・
# >> ○○○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+--------------------+--------|
# >> | 順位 | 候補手 | 読み筋             | 評価値 |
# >> |------+--------+--------------------+--------|
# >> |    1 | [0, 1] | [0, 2] PASS [2, 3] |     -9 |
# >> |------+--------+--------------------+--------|
# >> ------------------------------------------------------------ [5] x 実行速度:0.01149
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
# >> ------------------------------------------------------------ [6] o 実行速度:0.000203
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> (pass)
# >> ------------------------------------------------------------ [7] x 実行速度:0.00464
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
# >> ------------------------------------------------------------ [8] o 実行速度:0.000229
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> (pass)
# >> ------------------------------------------------------------ [9] x 実行速度:0.000157
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
