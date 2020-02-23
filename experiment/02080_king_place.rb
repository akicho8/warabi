require "./example_helper"

# mediator = Mediator.new
# mediator.player_at(:black).king_place # => nil
# mediator.placement_from_preset("平手")
# mediator.player_at(:black).king_place # => #<Bioshogi::Place ５九>
# mediator.execute("58玉")
# mediator.player_at(:black).king_place # => #<Bioshogi::Place ５八>
#
# mediator = Mediator.new
# mediator.placement_from_bod(<<~EOT)
# +---+
# |v玉|
# | 玉|
# +---+
# EOT
# mediator.player_at(:white).king_place # => #<Bioshogi::Place １一>
# mediator.player_at(:black).king_place # => #<Bioshogi::Place １二>

# Board.dimensiton_change([3, 3])
# mediator = Mediator.new
# mediator.placement_from_bod(<<~EOT)
# +---------+
# | ・ ・v玉|
# | ・ ・ ・|
# | ・ 金 ・|
# +---------+
#   EOT

# mediator.player_at(:white).king_place # => #<Bioshogi::Place １一>
# mediator.player_at(:black).king_place # => nil
# 
# brain = mediator.player_at(:black).brain(evaluator_class: Evaluator::Level2)
# brain.create_all_hands(promoted_only: true).collect(&:to_kif) # => ["▲３二金(23)", "▲２二金(23)", "▲１二金(23)", "▲３三金(23)", "▲１三金(23)"]
# tp brain.fast_score_list # => [{:hand=><▲３二金(23)>, :score=>41202, :socre2=>41202, :best_pv=>[], :eval_times=>1, :sec=>7.1e-05}, {:hand=><▲２二金(23)>, :score=>41202, :socre2=>41202, :best_pv=>[], :eval_times=>1, :sec=>3.2e-05}, {:hand=><▲１二金(23)>, :score=>41202, :socre2=>41202, :best_pv=>[], :eval_times=>1, :sec=>2.8e-05}, {:hand=><▲３三金(23)>, :score=>41202, :socre2=>41202, :best_pv=>[], :eval_times=>1, :sec=>2.7e-05}, {:hand=><▲１三金(23)>, :score=>41202, :socre2=>41202, :best_pv=>[], :eval_times=>1, :sec=>4.4e-05}]

Board.dimensiton_change([3, 1])
mediator = Mediator.new
mediator.placement_from_bod(<<~EOT)
+---------+
| ・ 金v玉|
+---------+
EOT
evaluator = mediator.player_at(:black).evaluator(evaluator_class: Evaluator::Level2)
evaluator.score                 # => 41201

mediator = Mediator.new
mediator.placement_from_bod(<<~EOT)
+---------+
| 金 ・v玉|
+---------+
EOT
evaluator = mediator.player_at(:black).evaluator(evaluator_class: Evaluator::Level2)
evaluator.score                 # => 41201

# >> #<Bioshogi::Place １一>
# >> #<Bioshogi::Place １一>
# >> #<Bioshogi::Place １一>
# >> #<Bioshogi::Place １一>
