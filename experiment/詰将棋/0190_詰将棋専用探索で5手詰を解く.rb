require "../example_helper"

Bioshogi.logger = ActiveSupport::Logger.new(STDOUT)

# Board.promotable_disable
Board.dimensiton_change([3, 9])

mediator = Mediator.new
mediator.player_at(:black).pieces_add("銀金")
# mediator.player_at(:white).pieces_add("飛2")
mediator.board.placement_from_shape <<~EOT
+---------+
|v金 ・v玉|
|v金 ・ ・|
| ・ 香 ・|
| 馬 ・v歩|
+---------+
EOT

# tp mediator.player_at(:black).normal_all_hands(promoted_only: false, legal_only: true, mate_only: true)

mate_records = []
mate_proc = -> player, score, hand_route {
  mate_records << {"評価値" => score, "詰み筋" => hand_route.collect(&:to_s).join(" "), "詰み側" => player.location.to_s, "攻め側の持駒" => player.op.piece_box.to_s}
}

# brain = mediator.player_at(:black).brain(diver_class: Diver::NegaScoutDiver)
# records = brain.iterative_deepening(depth_max_range: 5..5, mate_mode: true, mate_proc: mate_proc)
# tp Brain.human_format(records)

# player = mediator.player_at(:black)
# object = Diver::NegaAlphaMateDiver.new(evaluator_class: Evaluator::Level1, depth_max: 6, current_player: player, mate_mode: true, base_player: player, mate_proc: mate_proc)
# # object = Diver::NegaAlphaMateDiver.new(evaluator_class: Evaluator::Level1, depth_max: 5, current_player: player, mate_mode: true, base_player: player, mate_proc: mate_proc)
# tp object.dive

brain = mediator.player_at(:black).brain(diver_class: Diver::NegaAlphaMateDiver) # 詰将棋専用探索
records = brain.iterative_deepening(depth_max_range: 5..5, mate_mode: true, mate_proc: mate_proc, log_scope: "▲１二銀打 △１二玉(11) ▲２一香成(23)")
tp Brain.human_format(records)

tp "他の詰み筋。ただし全部取得するには NegaAlphaMateDiver のループのところでbreakしてはいけない。あと勝手読みの詰みも含まれるので意図した手順と異なることもある。あくまでデバッグ用"
tp mate_records

# >> #ROOT ▲２二香成(23)
# >> #ROOT ▲２一香成(23)
# >> #ROOT ▲３三馬(34)
# >> #ROOT ▲２一金打
# >> #ROOT ▲２二金打
# >> #ROOT ▲２二銀打
# >> #ROOT ▲１二金打
# >> #ROOT ▲１二銀打
# >>     2 △         王手解除の手を生成: △１三玉(12), △２一玉(12), △２三金(32), △２三銀打
# >>     2 △         △１三玉(12)
# >>     3 ▲             王手のみの手を生成: ▲２四馬(34), ▲３五馬(34), ▲２三馬(34), ▲１二馬(34), ▲１二金打, ▲２三金打, ▲２四金打
# >>     3 ▲             ▲２四馬(34)
# >>     4 △                 王手解除の手を生成: △２四玉(13), △１二玉(13)
# >>     4 △                 △２四玉(13)
# >>     5 ▲                     +0
# >>     4 △                 0, [] = dive
# >>     4 △                 if -999999 < 0
# >>     4 △                 alpha = 0
# >>     4 △                 best_pv = [<△２四玉(13)>]
# >>     4 △                 break if 0 >= -1
# >>     4 △                 ★確 △２四玉(13) (0) ---------------------------------------- ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲２四馬(34)
# >>     4 △                 return [0, [<△２四玉(13)>]]
# >>     3 ▲             0, [<△２四玉(13)>] = dive
# >>     3 ▲             if 1 < 0
# >>     3 ▲             ▲３五馬(34)
# >>     4 △                 王手解除の手を生成: △２三玉(13), △１二玉(13), △２四銀打
# >>     4 △                 △２三玉(13)
# >>     5 ▲                     +0
# >>     4 △                 0, [] = dive
# >>     4 △                 if -999999 < 0
# >>     4 △                 alpha = 0
# >>     4 △                 best_pv = [<△２三玉(13)>]
# >>     4 △                 break if 0 >= -1
# >>     4 △                 ★確 △２三玉(13) (0) ---------------------------------------- ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲３五馬(34)
# >>     4 △                 return [0, [<△２三玉(13)>]]
# >>     3 ▲             0, [<△２三玉(13)>] = dive
# >>     3 ▲             if 1 < 0
# >>     3 ▲             ▲２三馬(34)
# >>     4 △                 王手解除の手を生成: △２三金(32), △２三玉(13)
# >>     4 △                 △２三金(32)
# >>     5 ▲                     +0
# >>     4 △                 0, [] = dive
# >>     4 △                 if -999999 < 0
# >>     4 △                 alpha = 0
# >>     4 △                 best_pv = [<△２三金(32)>]
# >>     4 △                 break if 0 >= -1
# >>     4 △                 ★確 △２三金(32) (0) ---------------------------------------- ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲２三馬(34)
# >>     4 △                 return [0, [<△２三金(32)>]]
# >>     3 ▲             0, [<△２三金(32)>] = dive
# >>     3 ▲             if 1 < 0
# >>     3 ▲             ▲１二馬(34)
# >>     4 △                 王手解除の手を生成: △２四玉(13), △１二玉(13)
# >>     4 △                 △２四玉(13)
# >>     5 ▲                     +0
# >>     4 △                 0, [] = dive
# >>     4 △                 if -999999 < 0
# >>     4 △                 alpha = 0
# >>     4 △                 best_pv = [<△２四玉(13)>]
# >>     4 △                 break if 0 >= -1
# >>     4 △                 ★確 △２四玉(13) (0) ---------------------------------------- ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲１二馬(34)
# >>     4 △                 return [0, [<△２四玉(13)>]]
# >>     3 ▲             0, [<△２四玉(13)>] = dive
# >>     3 ▲             if 1 < 0
# >>     3 ▲             ▲１二金打
# >>     4 △                 王手解除の手を生成:
# >>     4 △                 ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲１二金打 のあとで合法手がない(=詰み)
# >>     3 ▲             -1, ["(詰み)"] = dive
# >>     3 ▲             if 1 < 1
# >>     3 ▲             ▲２三金打
# >>     4 △                 王手解除の手を生成: △２三金(32)
# >>     4 △                 △２三金(32)
# >>     5 ▲                     +0
# >>     4 △                 0, [] = dive
# >>     4 △                 if -999999 < 0
# >>     4 △                 alpha = 0
# >>     4 △                 best_pv = [<△２三金(32)>]
# >>     4 △                 break if 0 >= -1
# >>     4 △                 ★確 △２三金(32) (0) ---------------------------------------- ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲２三金打
# >>     4 △                 return [0, [<△２三金(32)>]]
# >>     3 ▲             0, [<△２三金(32)>] = dive
# >>     3 ▲             if 1 < 0
# >>     3 ▲             ▲２四金打
# >>     4 △                 王手解除の手を生成:
# >>     4 △                 ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲２四金打 のあとで合法手がない(=詰み)
# >>     3 ▲             -1, ["(詰み)"] = dive
# >>     3 ▲             if 1 < 1
# >>     3 ▲             return [1, []]
# >>     2 △         1, [] = dive
# >>     2 △         if -999999 < -1
# >>     2 △         alpha = -1
# >>     2 △         best_pv = [<△１三玉(12)>]
# >>     2 △         break if -1 >= -1
# >>     2 △         ★確 △１三玉(12) (-1) ---------------------------------------- ▲１二銀打 △１二玉(11) ▲２一香成(23)
# >>     2 △         return [-1, [<△１三玉(12)>]]
# >> |------+----------------+--------------------------------------------------------------------+--------+------------+----------+--------|
# >> | 順位 | 候補手         | 読み筋                                                             | ▲形勢 | 評価局面数 | 処理時間 | 他の手 |
# >> |------+----------------+--------------------------------------------------------------------+--------+------------+----------+--------|
# >> |    1 | ▲１二銀打     | △１二玉(11) ▲２二香成(23) △１三玉(12) ▲１二杏(22) (詰み)       |      1 |         31 |  0.30501 |        |
# >> |    2 | ▲２一香成(23) | △２一金(31) ▲３三馬(34) △１二玉(11) ▲２三馬(33) △２三玉(12)   |      0 |         51 | 0.454714 |        |
# >> |    3 | ▲３三馬(34)   | △３三金(32) ▲２二香成(23) △２二金(31) ▲２一金打 △１二玉(11)   |      0 |         48 | 0.550734 |        |
# >> |    4 | ▲２一金打     | △２一金(31) ▲３三馬(34) △３三金(32) ▲２二香成(23) △２二玉(11) |      0 |         31 | 0.366977 |        |
# >> |    5 | ▲２二香成(23) | △２二金(31) ▲１二馬(34) △１二玉(11) ▲２一銀打 △２一金(22)     |      0 |         50 | 0.394585 |        |
# >> |    6 | ▲２二銀打     | △２二金(32) ▲２二香成(23) △２二金(31) ▲１二馬(34) △１二玉(11) |      0 |         53 | 0.417308 |        |
# >> |    7 | ▲１二金打     | △１二玉(11) ▲２二香成(23) △２二玉(12) ▲３三馬(34) △３三金(32) |      0 |         34 | 0.300595 |        |
# >> |    8 | ▲２二金打     | △２二金(32) ▲２二香成(23) △２二金(31) ▲１二馬(34) △１二玉(11) |      0 |         19 |  0.17221 |        |
# >> |------+----------------+--------------------------------------------------------------------+--------+------------+----------+--------|
# >> |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
# >> | 他の詰み筋。ただし全部取得するには NegaAlphaMateDiver のループのところでbreakしてはいけない。あと勝手読みの詰みも含まれるので意図した手順と異なることもある。あくまでデバッグ用 |
# >> |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
# >> |--------+------------------------------------------------------------------+--------+--------------|
# >> | 評価値 | 詰み筋                                                           | 詰み側 | 攻め側の持駒 |
# >> |--------+------------------------------------------------------------------+--------+--------------|
# >> |     -1 | ▲３三馬(34) △３三金(32) ▲２二銀打 △１二玉(11) ▲１三金打     | △     |              |
# >> |     -1 | ▲２二銀打 △１二玉(11) ▲２一銀(22) △１三玉(12) ▲１二金打     | △     |              |
# >> |     -1 | ▲２二銀打 △１二玉(11) ▲２一銀(22) △１三玉(12) ▲２四金打     | △     |              |
# >> |     -1 | ▲２二銀打 △１二玉(11) ▲２一銀(22) △１一玉(12) ▲１二金打     | △     |              |
# >> |     -1 | ▲２二銀打 △１二玉(11) ▲１一銀成(22) △１三玉(12) ▲１二金打   | △     |              |
# >> |     -1 | ▲２二銀打 △１二玉(11) ▲１一銀成(22) △１三玉(12) ▲２四金打   | △     |              |
# >> |     -1 | ▲２二銀打 △１二玉(11) ▲１一金打                               | △     |              |
# >> |     -1 | ▲２二銀打 △１二玉(11) ▲１三金打                               | △     |              |
# >> |     -1 | ▲１二金打 △１二玉(11) ▲２二香成(23) △１三玉(12) ▲１二杏(22) | △     | 銀           |
# >> |     -1 | ▲１二金打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲２四銀打   | △     |              |
# >> |     -1 | ▲１二銀打 △１二玉(11) ▲２二香成(23) △１三玉(12) ▲１二杏(22) | △     | 金           |
# >> |     -1 | ▲１二銀打 △１二玉(11) ▲２二香成(23) △１三玉(12) ▲１二金打   | △     |              |
# >> |     -1 | ▲１二銀打 △１二玉(11) ▲２二香成(23) △２二玉(12) ▲１二金打   | △     |              |
# >> |     -1 | ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲１二金打   | △     |              |
# >> |     -1 | ▲１二銀打 △１二玉(11) ▲２一香成(23) △１三玉(12) ▲２四金打   | △     |              |
# >> |--------+------------------------------------------------------------------+--------+--------------|
