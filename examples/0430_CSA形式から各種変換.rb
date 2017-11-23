require "./example_helper"

# info = Parser.parse("N+hanairobiyori\nN-ispt\n+7968GI,-3334FU,+5756FU,-4132KI,+6857GI,-1314FU,+1716FU,-8384FU,+8879KA,-8485FU,+6978KI,-3142GI,+3948GI,-4233GI,+2726FU,-5152OU,+2625FU,-2231KA,+5969OU,-3142KA,+3736FU,-7162GI,+5746GI,-6172KI,+3635FU,-3435FU,+4635GI,-0034FU,+2524FU,-2324FU,+3524GI,-3324GI,+7924KA,-4224KA,+2824HI,-0023FU,+2428HI,-8586FU,+8786FU,-8286HI,+0087FU,-8656HI,+0057GI,-5636HI,+0037FU,-3635HI,+5746GI,-3585HI,+3736FU,-0033GI,+0068KA,-5354FU,+3635FU,-3435FU,+4635GI,-0034FU,+0024FU,-2324FU,+3524GI,-3324GI,+6824KA,-0023FU,+2468KA,-0033GI,+4958KI,-9394FU,+9796FU,-6253GI,+6979OU,-5344GI,+4857GI,-4435GI,+5746GI,-3546GI,+6846KA,-0039KA,+2818HI,-3975UM,+0076GI,-7576UM,+7776FU,-0055GI,+4668KA,-8582HI,+7988OU,-0027GI,+1848HI,-2736NG,+0037FU,-3627NG,+4849HI,-2738NG,+4979HI,-5556GI,+0057FU,-5645GI,+0077GI,-3435FU,+6766FU,-3536FU,+3736FU,-4536GI,+0037FU,-3627NG,+5756FU,-2728NG,+5867KI,-3829NG,+3736FU,-2919NG,+6846KA,-0044KY,+4628KA,-1918NG,+2839KA,-4447NY,+7949HI,-4737NY,+0048GI,-3738NY,+4959HI,-3839NY,+4839GI,-0037KA,+5979HI,-3726UM,+7768GI,-1817NG,+3938GI,-2636UM,+3849GI,-0037FU,+0048KY,-1727NG,+0047KA,-3635UM,+4758KA,-3738TO,+4847KY,-3849TO,+5849KA,-2737NG,+4958KA,-0038FU,+5869KA,-3839TO,+6857GI,-3536UM,+5746GI,-3747NG,+4657GI,-3949TO,+5768GI,-4948TO,+6877GI,-0046KE,+6947KA,-3647UM,+7919HI,-4858TO,+0079GI,-5857TO,+8898OU,-5767TO,+7867KI,-4658NK,+7788GI")
# puts info.to_ki2

# info = Parser.parse("+7776FU\n-3142GI\n+2726FU\n-5354FU\n+2625FU\n-4253GI\n+2524FU\n-2324FU\n+2824HI\n-4132KI\n+0023FU\n-2231KA\n+6978KI\n-5344GI\n+4958KI\n-1314FU\n+3948GI\n-8384FU\n+7968GI\n-8485FU\n+6877GI\n-7162GI\n+6766FU\n-5141OU\n+5969OU\n-6253GI\n+8879KA\n-4445GI\n+5867KI\n-4534GI\n+5756FU\n-3423GI\n+2428HI\n-0024FU\n+3736FU\n-3142KA\n+4837GI\n-4131OU\n+3726GI\n-5344GI\n+7968KA\n-3334FU\n+6979OU\n-4433GI\n+7988OU\n-3122OU\n+9796FU\n-9394FU\n+2937KE\n-4264KA\n+4746FU\n-7374FU\n+6665FU\n-6442KA\n+2858HI\n-7475FU\n+5655FU\n-5455FU\n+5855HI\n-7576FU\n+6776KI\n-0075FU\n+7666KI\n-3344GI\n+5558HI\n-8173KE\n+0054FU\n-6152KI\n+4645FU\n-4433GI\n+0074FU\n-7576FU\n+6676KI\n-0072FU\n+6846KA\n-8283HI\n+7473TO\n-8373HI\n+4673UM\n-7273FU\n+0082HI\n-5251KI\n+5453TO\n-0047KA\n+5857HI\n-4736UM\n+5342TO\n-5142KI\n+5751RY\n-3626UM\n+0025FU\n-2637UM\n+2524FU\n-2324GI\n+0054KE\n-0053GI\n+5442NK\n-5342GI\n+5161RY\n-3719UM\n+8281RY\n-0031KY\n+0041KI\n-7374FU\n+0053FU\n-4253GI\n+4131KI\n-5342GI\n+3132KI\n-2232OU\n+6121RY")
# info.move_infos # => [{:input=>"7776FU"}, {:input=>"3142GI"}, {:input=>"2726FU"}, {:input=>"5354FU"}, {:input=>"2625FU"}, {:input=>"4253GI"}, {:input=>"2524FU"}, {:input=>"2324FU"}, {:input=>"2824HI"}, {:input=>"4132KI"}, {:input=>"0023FU"}, {:input=>"2231KA"}, {:input=>"6978KI"}, {:input=>"5344GI"}, {:input=>"4958KI"}, {:input=>"1314FU"}, {:input=>"3948GI"}, {:input=>"8384FU"}, {:input=>"7968GI"}, {:input=>"8485FU"}, {:input=>"6877GI"}, {:input=>"7162GI"}, {:input=>"6766FU"}, {:input=>"5141OU"}, {:input=>"5969OU"}, {:input=>"6253GI"}, {:input=>"8879KA"}, {:input=>"4445GI"}, {:input=>"5867KI"}, {:input=>"4534GI"}, {:input=>"5756FU"}, {:input=>"3423GI"}, {:input=>"2428HI"}, {:input=>"0024FU"}, {:input=>"3736FU"}, {:input=>"3142KA"}, {:input=>"4837GI"}, {:input=>"4131OU"}, {:input=>"3726GI"}, {:input=>"5344GI"}, {:input=>"7968KA"}, {:input=>"3334FU"}, {:input=>"6979OU"}, {:input=>"4433GI"}, {:input=>"7988OU"}, {:input=>"3122OU"}, {:input=>"9796FU"}, {:input=>"9394FU"}, {:input=>"2937KE"}, {:input=>"4264KA"}, {:input=>"4746FU"}, {:input=>"7374FU"}, {:input=>"6665FU"}, {:input=>"6442KA"}, {:input=>"2858HI"}, {:input=>"7475FU"}, {:input=>"5655FU"}, {:input=>"5455FU"}, {:input=>"5855HI"}, {:input=>"7576FU"}, {:input=>"6776KI"}, {:input=>"0075FU"}, {:input=>"7666KI"}, {:input=>"3344GI"}, {:input=>"5558HI"}, {:input=>"8173KE"}, {:input=>"0054FU"}, {:input=>"6152KI"}, {:input=>"4645FU"}, {:input=>"4433GI"}, {:input=>"0074FU"}, {:input=>"7576FU"}, {:input=>"6676KI"}, {:input=>"0072FU"}, {:input=>"6846KA"}, {:input=>"8283HI"}, {:input=>"7473TO"}, {:input=>"8373HI"}, {:input=>"4673UM"}, {:input=>"7273FU"}, {:input=>"0082HI"}, {:input=>"5251KI"}, {:input=>"5453TO"}, {:input=>"0047KA"}, {:input=>"5857HI"}, {:input=>"4736UM"}, {:input=>"5342TO"}, {:input=>"5142KI"}, {:input=>"5751RY"}, {:input=>"3626UM"}, {:input=>"0025FU"}, {:input=>"2637UM"}, {:input=>"2524FU"}, {:input=>"2324GI"}, {:input=>"0054KE"}, {:input=>"0053GI"}, {:input=>"5442NK"}, {:input=>"5342GI"}, {:input=>"5161RY"}, {:input=>"3719UM"}, {:input=>"8281RY"}, {:input=>"0031KY"}, {:input=>"0041KI"}, {:input=>"7374FU"}, {:input=>"0053FU"}, {:input=>"4253GI"}, {:input=>"4131KI"}, {:input=>"5342GI"}, {:input=>"3132KI"}, {:input=>"2232OU"}, {:input=>"6121RY"}]
# puts info.to_ki2

info = Parser.parse(<<~EOT)
'encoding=Shift_JIS
' ---- Kifu for Windows V7 V7.31 CSA形式棋譜ファイル ----
V2.2
N+akicho8
N-yosui26
$EVENT:レーティング対局室(早指2)
$START_TIME:2017/11/15 0:23:44
P1-KY-KE-GI-KI-OU-KI-GI-KE-KY
P2 * -HI *  *  *  *  * -KA *
P3-FU-FU-FU-FU-FU-FU-FU-FU-FU
P4 *  *  *  *  *  *  *  *  *
P5 *  *  *  *  *  *  *  *  *
P6 *  *  *  *  *  *  *  *  *
P7+FU+FU+FU+FU+FU+FU+FU+FU+FU
P8 * +KA *  *  *  *  * +HI *
P9+KY+KE+GI+KI+OU+KI+GI+KE+KY
+
+7968GI,T5
-3334FU
%TORYO,T16
EOT

puts "-" * 80
puts info.to_kif
puts "-" * 80
puts info.to_ki2
puts "-" * 80
puts info.to_csa
# >> 先手：hanairobiyori
# >> 後手：ispt
# >> 
# >> ▲６八銀 △３四歩 ▲５六歩   △３二金   ▲５七銀 △１四歩   ▲１六歩   △８四歩   ▲７九角 △８五歩
# >> ▲７八金 △４二銀 ▲４八銀上 △３三銀   ▲２六歩 △５二玉   ▲２五歩   △３一角   ▲６九玉 △４二角
# >> ▲３六歩 △６二銀 ▲４六銀   △７二金   ▲３五歩 △同　歩   ▲同　銀   △３四歩   ▲２四歩 △同　歩
# >> ▲同　銀 △同　銀 ▲同　角   △同　角   ▲同　飛 △２三歩   ▲２八飛   △８六歩   ▲同　歩 △同　飛
# >> ▲８七歩 △５六飛 ▲５七銀打 △３六飛   ▲３七歩 △３五飛   ▲４六銀   △８五飛   ▲３六歩 △３三銀
# >> ▲６八角 △５四歩 ▲３五歩   △同　歩   ▲同　銀 △３四歩   ▲２四歩   △同　歩   ▲同　銀 △同　銀
# >> ▲同　角 △２三歩 ▲６八角   △３三銀   ▲５八金 △９四歩   ▲９六歩   △５三銀   ▲７九玉 △４四銀右
# >> ▲５七銀 △３五銀 ▲４六銀   △同　銀   ▲同　角 △３九角   ▲１八飛   △７五角成 ▲７六銀 △同　馬
# >> ▲同　歩 △５五銀 ▲６八角   △８二飛   ▲８八玉 △２七銀   ▲４八飛   △３六銀成 ▲３七歩 △２七全
# >> ▲４九飛 △３八全 ▲７九飛   △５六銀   ▲５七歩 △４五銀   ▲７七銀   △３五歩   ▲６六歩 △３六歩
# >> ▲同　歩 △同　銀 ▲３七歩   △２七銀成 ▲５六歩 △２八全上 ▲６七金右 △２九全右 ▲３六歩 △１九全寄
# >> ▲４六角 △４四香 ▲２八角   △１八全   ▲３九角 △４七香成 ▲４九飛   △３七杏   ▲４八銀 △３八杏
# >> ▲５九飛 △３九杏 ▲同　銀   △３七角   ▲７九飛 △２六角成 ▲６八銀   △１七全   ▲３八銀 △３六馬
# >> ▲４九銀 △３七歩 ▲４八香   △２七全   ▲４七角 △３五馬   ▲５八角   △３八歩成 ▲４七香 △４九と
# >> ▲同　角 △３七全 ▲５八角   △３八歩   ▲６九角 △３九歩成 ▲５七銀   △３六馬   ▲４六銀 △４七全
# >> ▲５七銀 △４九と ▲６八銀   △４八と   ▲７七銀 △４六桂   ▲４七角   △同　馬   ▲１九飛 △５八と
# >> ▲７九銀 △５七と ▲９八玉   △６七と   ▲同　金 △５八桂成 ▲８八銀引
# >> まで167手で先手の勝ち
# >> --------------------------------------------------------------------------------
# >> 先手：akicho8
# >> 後手：yosui26
# >> 棋戦：レーティング対局室(早指2)
# >> 開始日時：2017/11/15 0:23:44
# >> 手数----指手---------消費時間--
# >>    1 ６八銀(79)   (00:00/00:00:00)
# >>    2 ３四歩(33)   (00:00/00:00:00)
# >>    3 投了
# >> --------------------------------------------------------------------------------
# >> 先手：akicho8
# >> 後手：yosui26
# >> 棋戦：レーティング対局室(早指2)
# >> 開始日時：2017/11/15 0:23:44
# >> 
# >> ▲６八銀 △３四歩
# >> まで2手で後手の勝ち
# >> --------------------------------------------------------------------------------
# >> V2.2
# >> N+akicho8
# >> N-yosui26
# >> $EVENT:レーティング対局室(早指2)
# >> $START_TIME:2017/11/15 0:23:44
# >> PI
# >> +
# >> +7968GI
# >> -3334FU
# >> %TORYO
