# アルファ・ベータ法 - Wikipedia
# https://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%AB%E3%83%95%E3%82%A1%E3%83%BB%E3%83%99%E3%83%BC%E3%82%BF%E6%B3%95
#
# # ネガアルファ
# def alphabeta(node, depth, alpha, beta)
#   if node.end? || depth == 0
#     return node.score # 手番のプレイヤーから見た評価値
#   end
#
#   node.each do |e|
#     alpha = max(alpha, -alphabeta(e, depth-1, -beta, -alpha))
#     if alpha >= beta
#       break # カット
#     end
#   end
#
#   alpha
# end

require "./nega_max"

class NegaAlpha < NegaMax
  def compute_score(*args)
    nega_alpha(*args)
  end

  def nega_alpha(turn:, depth_max:, depth: 0, alpha: -Float::INFINITY, beta: Float::INFINITY)
    perform_out_of_time_check

    player = mediator.player_at(turn)

    # 一番深い局面に達したらはじめて評価する
    if depth_max <= depth
      return [mediator.evaluate(player), []] # 現局面手番視点
    end

    # 合法手がない場合はパスして相手に手番を渡す
    children = mediator.available_places(player)
    if children.empty?
      v, pv = nega_alpha(turn: turn + 1, depth_max: depth_max, depth: depth + 1, alpha: -beta, beta: -alpha)
      return [-v, [:pass, *pv]]
    end

    best_pv = []
    children.each do |place|
      mediator.place_on(player, place) do
        v, pv = nega_alpha(turn: turn + 1, depth_max: depth_max, depth: depth + 1, alpha: -beta, beta: -alpha)
        v = -v # 相手の一番良い手は自分の一番悪い手としたいので符号を反転する
        if v > alpha
          best_pv = [place, *pv]
          alpha = v
        end
      end
      if alpha >= beta
        break
      end
    end
    [alpha, best_pv]
  end
end

if $0 == __FILE__
  NegaAlpha.new.run             # => {:o=>1, :x=>10}
end
# >> ------------------------------------------------------------ [0] o 実行速度:0.022372
# >> ・○・・
# >> ・○○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------+------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 形勢 | 時間 |
# >> |------+--------+----------------------+--------+------+------|
# >> |    1 | [1, 0] | [0, 0] [3, 2] [2, 0] |      0 |    0 |      |
# >> |    2 | [0, 1] | [0, 0] [3, 2] [3, 1] |      0 |    0 |      |
# >> |    3 | [3, 2] | [1, 3] [0, 0] [1, 0] |      0 |    0 |      |
# >> |    4 | [2, 3] | [3, 1] [0, 0] [0, 1] |      0 |    0 |      |
# >> |------+--------+----------------------+--------+------+------|
# >> ------------------------------------------------------------ [1] x 実行速度:0.013633
# >> ×○・・
# >> ・×○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------+------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 形勢 | 時間 |
# >> |------+--------+----------------------+--------+------+------|
# >> |    1 | [0, 0] | [3, 2] [2, 0] [0, 1] |     -3 |    3 |      |
# >> |    2 | [0, 2] | [0, 3] [2, 0] [3, 0] |     -3 |    3 |      |
# >> |    3 | [2, 0] | [3, 0] [0, 0] [0, 1] |     -5 |    5 |      |
# >> |------+--------+----------------------+--------+------+------|
# >> ------------------------------------------------------------ [2] o 実行速度:0.011447
# >> ×○・・
# >> ・×○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+----------------------+--------+------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 形勢 | 時間 |
# >> |------+--------+----------------------+--------+------+------|
# >> |    1 | [3, 2] | [2, 0] [0, 1] [0, 2] |     -2 |   -2 |      |
# >> |    2 | [2, 3] | [2, 0] [0, 1] [0, 2] |     -2 |   -2 |      |
# >> |    3 | [0, 1] | [2, 0] [3, 2] [0, 2] |     -4 |   -4 |      |
# >> |------+--------+----------------------+--------+------+------|
# >> ------------------------------------------------------------ [3] x 実行速度:0.011076
# >> ×××・
# >> ・×○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+----------------------+--------+------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 形勢 | 時間 |
# >> |------+--------+----------------------+--------+------+------|
# >> |    1 | [2, 0] | [0, 1] [0, 2] PASS   |      2 |   -2 |      |
# >> |    2 | [3, 3] | [0, 1] [2, 0] [3, 0] |     -1 |    1 |      |
# >> |    3 | [1, 3] | [0, 1] [2, 0] [0, 2] |     -3 |    3 |      |
# >> |    4 | [3, 1] | [3, 0] [2, 0] [0, 1] |     -5 |    5 |      |
# >> |------+--------+----------------------+--------+------+------|
# >> ------------------------------------------------------------ [4] o 実行速度:0.00321
# >> ×××・
# >> ○○○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+--------------------+--------+------+------|
# >> | 順位 | 候補手 | 読み筋             | 評価値 | 形勢 | 時間 |
# >> |------+--------+--------------------+--------+------+------|
# >> |    1 | [0, 1] | [0, 2] PASS [2, 3] |     -9 |   -9 |      |
# >> |------+--------+--------------------+--------+------+------|
# >> ------------------------------------------------------------ [5] x 実行速度:0.010435
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> |------+--------+----------------------+--------+------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 形勢 | 時間 |
# >> |------+--------+----------------------+--------+------+------|
# >> |    1 | [0, 2] | PASS [2, 3] PASS     |      9 |   -9 |      |
# >> |    2 | [3, 3] | [2, 3] [0, 2] PASS   |      2 |   -2 |      |
# >> |    3 | [2, 3] | [3, 3] [0, 2] [3, 0] |      1 |   -1 |      |
# >> |    4 | [1, 3] | [0, 3] [3, 1] [3, 0] |     -1 |    1 |      |
# >> |------+--------+----------------------+--------+------+------|
# >> ------------------------------------------------------------ [6] o 実行速度:0.00021
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> (pass)
# >> ------------------------------------------------------------ [7] x 実行速度:0.004418
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> |------+--------+----------------------+--------+------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 形勢 | 時間 |
# >> |------+--------+----------------------+--------+------+------|
# >> |    1 | [2, 3] | PASS PASS PASS       |      9 |   -9 |      |
# >> |    2 | [1, 3] | [0, 3] [2, 3] [3, 0] |      4 |   -4 |      |
# >> |    3 | [3, 3] | [2, 3] [3, 1] [3, 0] |      4 |   -4 |      |
# >> |    4 | [3, 1] | [3, 0] [2, 3] [0, 3] |      2 |   -2 |      |
# >> |------+--------+----------------------+--------+------+------|
# >> ------------------------------------------------------------ [8] o 実行速度:0.000238
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> (pass)
# >> ------------------------------------------------------------ [9] x 実行速度:0.000161
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
