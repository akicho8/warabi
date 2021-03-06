require "./example_helper"
require 'active_support/core_ext/benchmark'

# Bioshogi.config[:skill_monitor_enable] = false

files = Pathname.glob("../../2chkifu/**/*.{ki2,KI2}").sort
files = Array(files).take((ARGV.first || 100).to_i)
seconds = Benchmark.realtime do
  files.each do |file|
    info = Parser.file_parse(file, typical_error_case: :skip, skill_monitor_technique_enable: true)
    info.to_kif
  end
end

p seconds
tp SkillMonitor.walk_counts.sort_by{|k, v|-v}.to_h
# >> 7.217185000015888
# >> |----------------------+-------|
# >> |                 駒柱 | 11262 |
# >> |                 入玉 | 891   |
# >> |               垂れ歩 | 847   |
# >> |             金底の歩 | 847   |
# >> |             雁木囲い | 585   |
# >> |           一直線穴熊 | 573   |
# >> |               総矢倉 | 527   |
# >> |               菱矢倉 | 484   |
# >> |               中原玉 | 469   |
# >> |           ツノ銀雁木 | 463   |
# >> |     阿久津流急戦矢倉 | 454   |
# >> |       かまいたち戦法 | 450   |
# >> |     チョコレート囲い | 424   |
# >> |           いちご囲い | 423   |
# >> |               金矢倉 | 419   |
# >> |         ボナンザ囲い | 403   |
# >> |               銀矢倉 | 394   |
# >> |             矢倉穴熊 | 392   |
# >> |     ダイヤモンド美濃 | 390   |
# >> |         楠本式石田流 | 375   |
# >> |               雀刺し | 365   |
# >> |           銀立ち矢倉 | 364   |
# >> |             中住まい | 360   |
# >> |         パンツを脱ぐ | 351   |
# >> |           松尾流穴熊 | 351   |
# >> |             四枚銀冠 | 344   |
# >> |             菊水矢倉 | 343   |
# >> |             美濃囲い | 341   |
# >> |       ちょんまげ美濃 | 333   |
# >> |       中原流急戦矢倉 | 327   |
# >> |               片矢倉 | 322   |
# >> |           アヒル囲い | 316   |
# >> |           アヒル戦法 | 316   |
# >> |             無敵囲い | 314   |
# >> |               左美濃 | 309   |
# >> |           天守閣美濃 | 303   |
# >> |             ビッグ４ | 300   |
# >> |           矢倉中飛車 | 296   |
# >> |               金無双 | 295   |
# >> |         あずまや囲い | 281   |
# >> |                 右玉 | 272   |
# >> |           カブト囲い | 270   |
# >> |       モノレール囲い | 265   |
# >> |             カニ囲い | 253   |
# >> |                 腹銀 | 249   |
# >> |         割り打ちの銀 | 249   |
# >> |             桂頭の銀 | 249   |
# >> |             四枚美濃 | 248   |
# >> |               舟囲い | 242   |
# >> |           高美濃囲い | 233   |
# >> |               金美濃 | 232   |
# >> |               継ぎ桂 | 230   |
# >> |             遠見の角 | 230   |
# >> |         ふんどしの桂 | 230   |
# >> |             左山囲い | 228   |
# >> |       米長流急戦矢倉 | 217   |
# >> |               裾固め | 215   |
# >> |               銀美濃 | 213   |
# >> |       ゴキゲン中飛車 | 210   |
# >> |             ずれ美濃 | 204   |
# >> |           カブト美濃 | 202   |
# >> |             エルモ囲い | 202   |
# >> |             銀冠穴熊 | 199   |
# >> |       初手３六歩戦法 | 193   |
# >> |               居飛車 | 190   |
# >> |         裏アヒル戦法 | 190   |
# >> |         裏アヒル囲い | 190   |
# >> |       矢倉左美濃急戦 | 188   |
# >> |             振り飛車 | 176   |
# >> |           相振り飛車 | 176   |
# >> |               超急戦 | 172   |
# >> |         陽動振り飛車 | 171   |
# >> |             端玉銀冠 | 167   |
# >> |       パックマン戦法 | 164   |
# >> |           角頭歩戦法 | 163   |
# >> |             木村美濃 | 161   |
# >> |             レグスペ | 157   |
# >> |       塚田スペシャル | 156   |
# >> |               早石田 | 155   |
# >> |         音無しの構え | 153   |
# >> |         藤井システム | 152   |
# >> |         ▲７二飛亜急戦 | 152   |
# >> |       ▲４五歩早仕掛け | 152   |
# >> |           片美濃囲い | 151   |
# >> |               右矢倉 | 150   |
# >> |           カニカニ銀 | 144   |
# >> |             坊主美濃 | 143   |
# >> |         対振り持久戦 | 133   |
# >> |   △３三角型空中戦法 | 133   |
# >> |               早囲い | 133   |
# >> |                 銀冠 | 128   |
# >> |               金多伝 | 123   |
# >> |           ５筋位取り | 119   |
# >> |           原始中飛車 | 119   |
# >> |             ロケット | 118   |
# >> |               嬉野流 | 118   |
# >> |             相掛かり | 117   |
# >> |             中田功XP | 114   |
# >> |               金銀橋 | 114   |
# >> |       ミレニアム囲い | 113   |
# >> |       右四間飛車急戦 | 113   |
# >> |         極限早繰り銀 | 112   |
# >> |           玉頭位取り | 112   |
# >> |               立石流四間飛車 | 108   |
# >> |         中飛車左穴熊 | 105   |
# >> |             木村定跡 | 103   |
# >> |               石田流 | 102   |
# >> |           居飛車穴熊 | 100   |
# >> |             角換わり | 95    |
# >> |           串カツ囲い | 95    |
# >> |               鬼殺し | 94    |
# >> |         △３三桂戦法 | 94    |
# >> |     鬼殺し向かい飛車 | 94    |
# >> |               勇気流 | 93    |
# >> |           高田流左玉 | 93    |
# >> |         魔界四間飛車 | 85    |
# >> |             腰掛け銀 | 75    |
# >> |     角換わり腰掛け銀 | 75    |
# >> |               銀雲雀 | 75    |
# >> |             空中楼閣 | 74    |
# >> |             箱入り娘 | 73    |
# >> |         升田式石田流 | 71    |
# >> |             新米長玉 | 71    |
# >> |             新石田流 | 68    |
# >> |               鳥刺し | 65    |
# >> |           矢倉早囲い | 65    |
# >> |             四間飛車 | 62    |
# >> |           脇システム | 60    |
# >> |           左美濃急戦 | 57    |
# >> |     角換わり早繰り銀 | 57    |
# >> |               真部流 | 57    |
# >> |         ▲４六銀左急戦 | 57    |
# >> |         ▲４六銀右急戦 | 57    |
# >> |                 超速 | 57    |
# >> |       新丸山ワクチン | 57    |
# >> |       初手７八銀戦法 | 57    |
# >> |             三手囲い | 54    |
# >> |               銀多伝 | 54    |
# >> |       目くらまし戦法 | 53    |
# >> |         △２三歩戦法 | 53    |
# >> |             矢倉棒銀 | 51    |
# >> |         角換わり棒銀 | 51    |
# >> |           ▲３七銀戦法 | 51    |
# >> |       中原流相掛かり | 51    |
# >> |         森下システム | 48    |
# >> |           きｍきｍ金 | 46    |
# >> |       きんとうん戦法 | 44    |
# >> |           ４→３戦法 | 43    |
# >> |             新鬼殺し | 43    |
# >> |         羽生式袖飛車 | 43    |
# >> |               袖飛車 | 43    |
# >> |             鷺宮定跡 | 43    |
# >> |         加藤流袖飛車 | 43    |
# >> |       菅井流三間飛車 | 43    |
# >> |     うっかり三間飛車 | 43    |
# >> |             三間飛車 | 43    |
# >> |         △３ニ飛戦法 | 43    |
# >> |         ▲７八飛戦法 | 43    |
# >> |               遠山流 | 42    |
# >> |           ひねり飛車 | 40    |
# >> |           ポンポン桂 | 40    |
# >> |           ▲５七金戦法 | 40    |
# >> |     右四間飛車左美濃 | 38    |
# >> |     英ちゃん流中飛車 | 38    |
# >> |           右四間飛車 | 38    |
# >> |       メイドシステム | 33    |
# >> |         振り飛車穴熊 | 33    |
# >> |     飯島流引き角戦法 | 33    |
# >> |               青野流 | 32    |
# >> |           無責任矢倉 | 32    |
# >> |                UFO銀 | 30    |
# >> |               鎖鎌銀 | 30    |
# >> |         相掛かり棒銀 | 29    |
# >> |             原始棒銀 | 29    |
# >> |           向かい飛車 | 28    |
# >> |               玉頭銀 | 28    |
# >> | ダイレクト向かい飛車 | 28    |
# >> |   メリケン向かい飛車 | 28    |
# >> |         阪田流向飛車 | 28    |
# >> |       穴角向かい飛車 | 28    |
# >> |                 平目 | 26    |
# >> |               端棒銀 | 26    |
# >> |               新風車 | 25    |
# >> |             中原飛車 | 25    |
# >> |   つくつくぼうし戦法 | 24    |
# >> |                 棒銀 | 22    |
# >> |           相横歩取り | 21    |
# >> |             横歩取り | 21    |
# >> |               四手角 | 20    |
# >> |         ▲８五飛車戦法 | 20    |
# >> |       一手損角換わり | 19    |
# >> |               都成流△３一金 | 19    |
# >> |           美濃熊囲い | 19    |
# >> |       角交換振り飛車 | 19    |
# >> |         丸山ワクチン | 19    |
# >> |             稲庭戦法 | 12    |
# >> |                 風車 | 11    |
# >> |         ツノ銀中飛車 | 11    |
# >> |         一間飛車穴熊 | 10    |
# >> |             四段端玉 | 8     |
# >> |           トマホーク | 8     |
# >> |             筋違い角 | 7     |
# >> |           相筋違い角 | 7     |
# >> |                 棒金 | 7     |
# >> |         △４五角戦法 | 5     |
# >> |             一間飛車 | 2     |
# >> |           地下鉄飛車 | 1     |
# >> |----------------------+-------|
