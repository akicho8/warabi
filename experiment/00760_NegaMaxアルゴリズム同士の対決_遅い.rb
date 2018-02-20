# NegaMaxアルゴリズム同士の対決

require "./example_helper"

mediator = Mediator.start
mediator.piece_plot
loop do
  think_result = mediator.current_player.brain.nega_max_run(depth_max: 1, random: true)
  hand = InputParser.slice_one(think_result[:hand])
  p hand
  mediator.execute(hand)
  p mediator
  killed_soldier = mediator.opponent_player.executor.killed_soldier
  # break
  if killed_soldier && killed_soldier.piece.key == :king
    break
  end
end
p mediator.to_kif_a.join(" ")
