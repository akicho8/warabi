require "./example_helper"

# Bioshogi.logger = ActiveSupport::Logger.new(STDOUT)

Board.dimensiton_change([2, 5])
[
  NegaAlphaDiver,
  NegaScoutDiver,
].each do |diver_class|
  mediator = Mediator.new
  mediator.board.placement_from_shape <<~EOT
  +------+
  | ・v香|
  | ・v飛|
  | ・v歩|
  | ・ 飛|
  | ・ 香|
  +------+
    EOT
  brain = mediator.player_at(:black).brain(diver_class: diver_class)
  tp brain.iterative_deepening(depth_max_range: 0..0) # => [{:hand=><▲１三飛成(14)>, :score=>305, :score2=>305, :best_pv=>[], :eval_times=>1, :sec=>4.2e-05}, {:hand=><▲２四飛(14)>, :score=>-100, :score2=>-100, :best_pv=>[], :eval_times=>1, :sec=>1.4e-05}], [{:hand=><▲１三飛成(14)>, :score=>305, :score2=>305, :best_pv=>[], :eval_times=>1, :sec=>2.1e-05}, {:hand=><▲２四飛(14)>, :score=>-100, :score2=>-100, :best_pv=>[], :eval_times=>1, :sec=>1.2e-05}]
  tp brain.iterative_deepening(depth_max_range: 0..1) # => [{:hand=><▲２四飛(14)>, :score=>-1200, :score2=>-1200, :best_pv=>[<△１四歩成(13)>], :eval_times=>2, :sec=>0.000396}, {:hand=><▲１三飛成(14)>, :score=>-4195, :score2=>-4195, :best_pv=>[<△１三飛成(12)>], :eval_times=>2, :sec=>0.000447}], [{:hand=><▲２四飛(14)>, :score=>-1200, :score2=>-1200, :best_pv=>[<△１四歩成(13)>], :eval_times=>3, :sec=>0.000443}, {:hand=><▲１三飛成(14)>, :score=>-4195, :score2=>-4195, :best_pv=>[<△１三飛成(12)>], :eval_times=>2, :sec=>0.00042}]
  tp brain.iterative_deepening(depth_max_range: 0..2) # => [{:hand=><▲１三飛成(14)>, :score=>705, :score2=>705, :best_pv=>[<△１三飛成(12)>, <▲１三香成(15)>], :eval_times=>10, :sec=>0.002552}, {:hand=><▲２四飛(14)>, :score=>105, :score2=>105, :best_pv=>[<△１四歩成(13)>, <▲１四香(15)>], :eval_times=>12, :sec=>0.004181}], [{:hand=><▲１三飛成(14)>, :score=>705, :score2=>705, :best_pv=>[<△１三飛成(12)>, <▲１三香成(15)>], :eval_times=>11, :sec=>0.002768}, {:hand=><▲２四飛(14)>, :score=>105, :score2=>105, :best_pv=>[<△１四歩成(13)>, <▲１四香(15)>], :eval_times=>15, :sec=>0.003173}]
  tp brain.iterative_deepening(depth_max_range: 0..3) # => [{:hand=><▲２四飛(14)>, :score=>-1325, :score2=>-1325, :best_pv=>[<△１四歩成(13)>, <▲１四香(15)>, <△１四飛成(12)>], :eval_times=>30, :sec=>0.00704}, {:hand=><▲１三飛成(14)>, :score=>-1725, :score2=>-1725, :best_pv=>[<△１三飛成(12)>, <▲１三香成(15)>, <△１三香成(11)>], :eval_times=>40, :sec=>0.010101}], [{:hand=><▲２四飛(14)>, :score=>-1325, :score2=>-1325, :best_pv=>[<△１四歩成(13)>, <▲１四香(15)>, <△１四飛成(12)>], :eval_times=>45, :sec=>0.013806}, {:hand=><▲１三飛成(14)>, :score=>-1725, :score2=>-1725, :best_pv=>[<△１三飛成(12)>, <▲１三香成(15)>, <△１三香成(11)>], :eval_times=>38, :sec=>0.009179}]
  tp brain.iterative_deepening(depth_max_range: 0..4) # => [{:hand=><▲２四飛(14)>, :score=>2975, :score2=>2975, :best_pv=>[<△１四歩成(13)>, <▲１四香(15)>, <△１四飛成(12)>, <▲１四飛(24)>], :eval_times=>154, :sec=>0.036228}, {:hand=><▲１三飛成(14)>, :score=>-1730, :score2=>-1730, :best_pv=>[<△１三飛成(12)>, <▲１三香成(15)>, <△１三香成(11)>, <▲２二歩打>], :eval_times=>135, :sec=>0.032467}], [{:hand=><▲２四飛(14)>, :score=>2975, :score2=>2975, :best_pv=>[<△１四歩成(13)>, <▲１四香(15)>, <△１四飛成(12)>, <▲１四飛(24)>], :eval_times=>185, :sec=>0.050293}, {:hand=><▲１三飛成(14)>, :score=>-1730, :score2=>-1730, :best_pv=>[<△１三飛成(12)>, <▲１三香成(15)>, <△１三香成(11)>, <▲２二歩打>], :eval_times=>140, :sec=>0.052758}]
end
# >> |----------------+-------+--------+---------+------------+---------|
# >> | hand           | score | score2 | best_pv | eval_times | sec     |
# >> |----------------+-------+--------+---------+------------+---------|
# >> | ▲１三飛成(14) |   305 |    305 | []      |          1 | 4.2e-05 |
# >> | ▲２四飛(14)   |  -100 |   -100 | []      |          1 | 1.4e-05 |
# >> |----------------+-------+--------+---------+------------+---------|
# >> |----------------+-------+--------+--------------------+------------+----------|
# >> | hand           | score | score2 | best_pv            | eval_times | sec      |
# >> |----------------+-------+--------+--------------------+------------+----------|
# >> | ▲２四飛(14)   | -1200 |  -1200 | [<△１四歩成(13)>] |          2 | 0.000396 |
# >> | ▲１三飛成(14) | -4195 |  -4195 | [<△１三飛成(12)>] |          2 | 0.000447 |
# >> |----------------+-------+--------+--------------------+------------+----------|
# >> |----------------+-------+--------+--------------------------------------+------------+----------|
# >> | hand           | score | score2 | best_pv                              | eval_times | sec      |
# >> |----------------+-------+--------+--------------------------------------+------------+----------|
# >> | ▲１三飛成(14) |   705 |    705 | [<△１三飛成(12)>, <▲１三香成(15)>] |         10 | 0.002552 |
# >> | ▲２四飛(14)   |   105 |    105 | [<△１四歩成(13)>, <▲１四香(15)>]   |         12 | 0.004181 |
# >> |----------------+-------+--------+--------------------------------------+------------+----------|
# >> |----------------+-------+--------+--------------------------------------------------------+------------+----------|
# >> | hand           | score | score2 | best_pv                                                | eval_times | sec      |
# >> |----------------+-------+--------+--------------------------------------------------------+------------+----------|
# >> | ▲２四飛(14)   | -1325 |  -1325 | [<△１四歩成(13)>, <▲１四香(15)>, <△１四飛成(12)>]   |         30 |  0.00704 |
# >> | ▲１三飛成(14) | -1725 |  -1725 | [<△１三飛成(12)>, <▲１三香成(15)>, <△１三香成(11)>] |         40 | 0.010101 |
# >> |----------------+-------+--------+--------------------------------------------------------+------------+----------|
# >> |----------------+-------+--------+----------------------------------------------------------------------+------------+----------|
# >> | hand           | score | score2 | best_pv                                                              | eval_times | sec      |
# >> |----------------+-------+--------+----------------------------------------------------------------------+------------+----------|
# >> | ▲２四飛(14)   |  2975 |   2975 | [<△１四歩成(13)>, <▲１四香(15)>, <△１四飛成(12)>, <▲１四飛(24)>] |        154 | 0.036228 |
# >> | ▲１三飛成(14) | -1730 |  -1730 | [<△１三飛成(12)>, <▲１三香成(15)>, <△１三香成(11)>, <▲２二歩打>] |        135 | 0.032467 |
# >> |----------------+-------+--------+----------------------------------------------------------------------+------------+----------|
# >> |----------------+-------+--------+---------+------------+---------|
# >> | hand           | score | score2 | best_pv | eval_times | sec     |
# >> |----------------+-------+--------+---------+------------+---------|
# >> | ▲１三飛成(14) |   305 |    305 | []      |          1 | 2.1e-05 |
# >> | ▲２四飛(14)   |  -100 |   -100 | []      |          1 | 1.2e-05 |
# >> |----------------+-------+--------+---------+------------+---------|
# >> |----------------+-------+--------+--------------------+------------+----------|
# >> | hand           | score | score2 | best_pv            | eval_times | sec      |
# >> |----------------+-------+--------+--------------------+------------+----------|
# >> | ▲２四飛(14)   | -1200 |  -1200 | [<△１四歩成(13)>] |          3 | 0.000443 |
# >> | ▲１三飛成(14) | -4195 |  -4195 | [<△１三飛成(12)>] |          2 |  0.00042 |
# >> |----------------+-------+--------+--------------------+------------+----------|
# >> |----------------+-------+--------+--------------------------------------+------------+----------|
# >> | hand           | score | score2 | best_pv                              | eval_times | sec      |
# >> |----------------+-------+--------+--------------------------------------+------------+----------|
# >> | ▲１三飛成(14) |   705 |    705 | [<△１三飛成(12)>, <▲１三香成(15)>] |         11 | 0.002768 |
# >> | ▲２四飛(14)   |   105 |    105 | [<△１四歩成(13)>, <▲１四香(15)>]   |         15 | 0.003173 |
# >> |----------------+-------+--------+--------------------------------------+------------+----------|
# >> |----------------+-------+--------+--------------------------------------------------------+------------+----------|
# >> | hand           | score | score2 | best_pv                                                | eval_times | sec      |
# >> |----------------+-------+--------+--------------------------------------------------------+------------+----------|
# >> | ▲２四飛(14)   | -1325 |  -1325 | [<△１四歩成(13)>, <▲１四香(15)>, <△１四飛成(12)>]   |         45 | 0.013806 |
# >> | ▲１三飛成(14) | -1725 |  -1725 | [<△１三飛成(12)>, <▲１三香成(15)>, <△１三香成(11)>] |         38 | 0.009179 |
# >> |----------------+-------+--------+--------------------------------------------------------+------------+----------|
# >> |----------------+-------+--------+----------------------------------------------------------------------+------------+----------|
# >> | hand           | score | score2 | best_pv                                                              | eval_times | sec      |
# >> |----------------+-------+--------+----------------------------------------------------------------------+------------+----------|
# >> | ▲２四飛(14)   |  2975 |   2975 | [<△１四歩成(13)>, <▲１四香(15)>, <△１四飛成(12)>, <▲１四飛(24)>] |        185 | 0.050293 |
# >> | ▲１三飛成(14) | -1730 |  -1730 | [<△１三飛成(12)>, <▲１三香成(15)>, <△１三香成(11)>, <▲２二歩打>] |        140 | 0.052758 |
# >> |----------------+-------+--------+----------------------------------------------------------------------+------------+----------|
