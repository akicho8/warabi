require "./example_helper"

# Board.logger = ActiveSupport::Logger.new(STDOUT)
# Board.promotable_disable
# Board.dimensiton_change([3, 3])
mediator = Mediator.new
mediator.placement_from_bod <<~EOT
後手の持駒：
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
|v香v桂v銀v金v玉v金v銀v桂v香|一
| ・v飛 ・ ・ ・ ・ ・v角 ・|二
|v歩v歩v歩v歩v歩v歩v歩v歩v歩|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
先手の持駒：
手数＝0
EOT

hand = mediator.current_player.normal_all_hands.first # => <▲９六歩(97)>
Benchmark.ms { hand.legal_move?(mediator)  }                   # => 1.5039999270811677
Benchmark.ms { mediator.current_player.normal_all_hands.to_a } # => 2.921000006608665
Benchmark.ms { mediator.current_player.legal_all_hands.to_a  } # => 22.844999912194908
