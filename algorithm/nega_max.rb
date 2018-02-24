require "./beauty_minimax"

class NegaMax < BeautyMinimax
  def mini_max(*args)
    nega_max(*args)
  end

  def nega_max(turn, depth, depth_max)
    player = app.player_at(turn)

    # 一番深い局面に達したらはじめて評価する
    if depth >= depth_max
      return [app.evaluate(player), []] # ミニマックスのときとは異なり player から見たscore
    end

    # 合法手がない場合はパスして相手に手番を渡す
    children = app.available_points(player)
    if children.empty?
      score, before = nega_max(turn + 1, depth + 1, depth_max)
      return [-score, [:pass, *before]]
    end

    max = -Float::INFINITY
    hands = []

    children.each do |point|
      memento = app.board.dup
      app.assert_put_on(player, point)
      app.put_on(player, point)
      score, before = nega_max(turn + 1, depth + 1, depth_max)
      app.board = memento
      score = -score # 相手の一番良い手は自分の一番悪い手としたいので符号を反転する
      if score > max
        hands = [point, *before]
        max = score
      end
    end

    [max, hands]
  end
end

if $0 == __FILE__
  NegaMax.new.run
end
# >> ---------------------------------------- [0] o 評価値:3 読み:[[1, 0], [0, 0], [0, 1]]
# >> ・○・・
# >> ・○○・
# >> ・○×・
# >> ・・・・
# >> ---------------------------------------- [1] x 評価値:0 読み:[[0, 0], [3, 2], [2, 0]]
# >> ×○・・
# >> ・×○・
# >> ・○×・
# >> ・・・・
# >> ---------------------------------------- [2] o 評価値:3 読み:[[3, 2], [2, 0], [0, 1]]
# >> ×○・・
# >> ・×○・
# >> ・○○○
# >> ・・・・
# >> ---------------------------------------- [3] x 評価値:2 読み:[[2, 0], [0, 1], [0, 2]]
# >> ×××・
# >> ・×○・
# >> ・○○○
# >> ・・・・
# >> ---------------------------------------- [4] o 評価値:-2 読み:[[0, 1], [0, 2], :pass]
# >> ×××・
# >> ○○○・
# >> ・○○○
# >> ・・・・
# >> ---------------------------------------- [5] x 評価値:9 読み:[[0, 2], :pass, [2, 3]]
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> ---------------------------------------- [6] o 評価値:-9 読み:[:pass, [2, 3], :pass]
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> ---------------------------------------- [7] x 評価値:9 読み:[[1, 3], [0, 3], [2, 3]]
# >> ×××・
# >> ××○・
# >> ××○○
# >> ・×・・
# >> ---------------------------------------- [8] o 評価値:-4 読み:[[0, 3], [2, 3], [3, 0]]
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ○×・・
# >> ---------------------------------------- [9] x 評価値:5 読み:[[3, 1], [3, 0], [2, 3]]
# >> ×××・
# >> ××××
# >> ×○×○
# >> ○×・・
# >> ---------------------------------------- [10] o 評価値:0 読み:[[3, 0], [2, 3], [3, 3]]
# >> ×××○
# >> ××○○
# >> ×○×○
# >> ○×・・
# >> ---------------------------------------- [11] x 評価値:0 読み:[[2, 3], [3, 3], :pass]
# >> ×××○
# >> ××○○
# >> ×××○
# >> ○××・
# >> ---------------------------------------- [12] o 評価値:0 読み:[[3, 3], :pass, :pass]
# >> ×××○
# >> ××○○
# >> ×××○
# >> ○○○○
# >> |---+---|
# >> | o | 8 |
# >> | x | 8 |
# >> |---+---|
