require "./example_helper"

mediator = Mediator.start
mediator.execute("▲２六歩")
mediator.execute("△３四歩")
player = mediator.player_at(:black)
player_executor = PlayerExecutorHuman.new(player, "▲５五銀")
player_executor.execute

mediator = Mediator.start
mediator.execute("▲22角成")    # => 
# ~> /Users/ikeda/src/warabi/lib/warabi/player_executor_base.rb:83:in `raise_error': 移動できる駒がなく打の省略形と思われる指し手ですが銀を持っていません (Warabi::HoldPieceNotFound2)
# ~> 手番: 先手
# ~> 指し手: ▲５五銀
# ~> 棋譜: ２六歩(27) ３四歩(33)
# ~> 後手の持駒：なし
# ~>   ９ ８ ７ ６ ５ ４ ３ ２ １
# ~> +---------------------------+
# ~> |v香v桂v銀v金v玉v金v銀v桂v香|一
# ~> | ・v飛 ・ ・ ・ ・ ・v角 ・|二
# ~> |v歩v歩v歩v歩v歩v歩 ・v歩v歩|三
# ~> | ・ ・ ・ ・ ・ ・v歩 ・ ・|四
# ~> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# ~> | ・ ・ ・ ・ ・ ・ ・ 歩 ・|六
# ~> | 歩 歩 歩 歩 歩 歩 歩 ・ 歩|七
# ~> | ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
# ~> | 香 桂 銀 金 玉 金 銀 桂 香|九
# ~> +---------------------------+
# ~> 先手の持駒：なし
# ~> 手数＝2 △３四歩(33) まで
# ~> 
# ~> 先手番
# ~> 	from /Users/ikeda/src/warabi/lib/warabi/player_executor_base.rb:33:in `execute'
# ~> 	from -:8:in `<main>'
