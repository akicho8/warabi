require "./example_helper"
require 'active_support/core_ext/benchmark'

# Warabi.config[:skill_monitor_enable] = false

files = Pathname.glob("../../2chkifu/**/*.{ki2,KI2}").sort
files = Array(files).take((ARGV.first || 100).to_i)
seconds = Benchmark.realtime do
  files.each do |file|
    info = Parser.file_parse(file, typical_error_case: :skip)
    info.to_kif
  end
end

p seconds
tp SkillMonitor.walk_counts.sort_by{|k, v|-v}.to_h
# >> 5.900768999941647
# >> |----------------------+------|
# >> |                 腹銀 | 1720 |
# >> |             桂頭の銀 | 1720 |
# >> |           脇システム | 989  |
# >> |             カニ囲い | 929  |
# >> |               垂れ歩 | 847  |
# >> |             金底の歩 | 847  |
# >> |               舟囲い | 808  |
# >> |       米長流急戦矢倉 | 672  |
# >> |           いちご囲い | 666  |
# >> |         森下システム | 620  |
# >> |           ツノ銀雁木 | 596  |
# >> |             雁木囲い | 585  |
# >> |           一直線穴熊 | 573  |
# >> |               総矢倉 | 527  |
# >> |               菱矢倉 | 484  |
# >> |               中原玉 | 469  |
# >> |     阿久津流急戦矢倉 | 454  |
# >> |       かまいたち戦法 | 437  |
# >> |               金矢倉 | 419  |
# >> |         ボナンザ囲い | 403  |
# >> |               銀矢倉 | 394  |
# >> |             矢倉穴熊 | 392  |
# >> |     ダイヤモンド美濃 | 390  |
# >> |           アヒル戦法 | 377  |
# >> |           無責任矢倉 | 376  |
# >> |         楠本式石田流 | 375  |
# >> |               雀刺し | 365  |
# >> |           銀立ち矢倉 | 364  |
# >> |             中住まい | 360  |
# >> |       ちょんまげ美濃 | 353  |
# >> |           松尾流穴熊 | 351  |
# >> |         パンツを脱ぐ | 351  |
# >> |             菊水矢倉 | 344  |
# >> |             美濃囲い | 341  |
# >> |       中原流急戦矢倉 | 327  |
# >> |               片矢倉 | 322  |
# >> |           アヒル囲い | 316  |
# >> |               左美濃 | 316  |
# >> |             無敵囲い | 314  |
# >> |           天守閣美濃 | 303  |
# >> |             ビッグ４ | 300  |
# >> |           矢倉中飛車 | 296  |
# >> |               金無双 | 295  |
# >> |                 右玉 | 272  |
# >> |             四枚美濃 | 272  |
# >> |               金美濃 | 262  |
# >> |         割り打ちの銀 | 249  |
# >> |           高美濃囲い | 233  |
# >> |             遠見の角 | 230  |
# >> |               継ぎ桂 | 230  |
# >> |         ふんどしの桂 | 230  |
# >> |             左山囲い | 228  |
# >> |               銀美濃 | 213  |
# >> |       ゴキゲン中飛車 | 210  |
# >> |             elmo囲い | 202  |
# >> |             銀冠穴熊 | 199  |
# >> |             端玉銀冠 | 195  |
# >> |       初手３六歩戦法 | 193  |
# >> |       矢倉左美濃急戦 | 188  |
# >> |           相振り飛車 | 176  |
# >> |               超急戦 | 172  |
# >> |         陽動振り飛車 | 171  |
# >> |           片美濃囲い | 164  |
# >> |       パックマン戦法 | 164  |
# >> |             坊主美濃 | 163  |
# >> |           角頭歩戦法 | 163  |
# >> |             木村美濃 | 161  |
# >> |             レグスペ | 157  |
# >> |       塚田スペシャル | 156  |
# >> |               早石田 | 155  |
# >> |       ４五歩早仕掛け | 152  |
# >> |         ７二飛亜急戦 | 152  |
# >> |         藤井システム | 152  |
# >> |               右矢倉 | 150  |
# >> |           カニカニ銀 | 144  |
# >> |   △３三角型空中戦法 | 133  |
# >> |         対振り持久戦 | 133  |
# >> |                 銀冠 | 128  |
# >> |           原始中飛車 | 119  |
# >> |           ５筋位取り | 119  |
# >> |               嬉野流 | 118  |
# >> |             ロケット | 118  |
# >> |             相掛かり | 117  |
# >> |             中田功XP | 114  |
# >> |       ミレニアム囲い | 113  |
# >> |       右四間飛車急戦 | 113  |
# >> |         極限早繰り銀 | 112  |
# >> |           玉頭位取り | 112  |
# >> |               立石流 | 108  |
# >> |         中飛車左穴熊 | 105  |
# >> |             木村定跡 | 103  |
# >> |               石田流 | 102  |
# >> |           居飛車穴熊 | 100  |
# >> |           串カツ囲い | 100  |
# >> |             角換わり | 95   |
# >> |         △３三桂戦法 | 94   |
# >> |     鬼殺し向かい飛車 | 94   |
# >> |               鬼殺し | 94   |
# >> |           高田流左玉 | 93   |
# >> |               勇気流 | 93   |
# >> |         魔界四間飛車 | 85   |
# >> |             腰掛け銀 | 75   |
# >> |     角換わり腰掛け銀 | 75   |
# >> |             箱入り娘 | 73   |
# >> |             新米長玉 | 71   |
# >> |         升田式石田流 | 71   |
# >> |             新石田流 | 68   |
# >> |           矢倉早囲い | 65   |
# >> |               鳥刺し | 65   |
# >> |             四間飛車 | 62   |
# >> |       新丸山ワクチン | 57   |
# >> |       初手７八銀戦法 | 57   |
# >> |               真部流 | 57   |
# >> |                 超速 | 57   |
# >> |           左美濃急戦 | 57   |
# >> |         ４六銀右急戦 | 57   |
# >> |         ４六銀左急戦 | 57   |
# >> |     角換わり早繰り銀 | 57   |
# >> |         △２三歩戦法 | 53   |
# >> |       目くらまし戦法 | 53   |
# >> |           ３七銀戦法 | 51   |
# >> |       中原流相掛かり | 51   |
# >> |             矢倉棒銀 | 51   |
# >> |         角換わり棒銀 | 51   |
# >> |           きｍきｍ金 | 46   |
# >> |       きんとうん戦法 | 44   |
# >> |         ▲７八飛戦法 | 43   |
# >> |         △３ニ飛戦法 | 43   |
# >> |               袖飛車 | 43   |
# >> |             鷺宮定跡 | 43   |
# >> |         加藤流袖飛車 | 43   |
# >> |       菅井流三間飛車 | 43   |
# >> |     うっかり三間飛車 | 43   |
# >> |             新鬼殺し | 43   |
# >> |           ４→３戦法 | 43   |
# >> |             三間飛車 | 43   |
# >> |         羽生式袖飛車 | 43   |
# >> |               遠山流 | 42   |
# >> |           ポンポン桂 | 40   |
# >> |           ひねり飛車 | 40   |
# >> |           ５七金戦法 | 40   |
# >> |     英ちゃん流中飛車 | 38   |
# >> |           右四間飛車 | 38   |
# >> |     右四間飛車左美濃 | 38   |
# >> |     飯島流引き角戦法 | 33   |
# >> |         振り飛車穴熊 | 33   |
# >> |               青野流 | 32   |
# >> |                UFO銀 | 30   |
# >> |               鎖鎌銀 | 30   |
# >> |             原始棒銀 | 29   |
# >> |         相掛かり棒銀 | 29   |
# >> |               玉頭銀 | 28   |
# >> |       穴角向かい飛車 | 28   |
# >> |   メリケン向かい飛車 | 28   |
# >> |           向かい飛車 | 28   |
# >> | ダイレクト向かい飛車 | 28   |
# >> |         阪田流向飛車 | 28   |
# >> |                 平目 | 26   |
# >> |               新風車 | 25   |
# >> |             中原飛車 | 25   |
# >> |   つくつくぼうし戦法 | 24   |
# >> |                 棒銀 | 22   |
# >> |             横歩取り | 21   |
# >> |           相横歩取り | 21   |
# >> |               四手角 | 20   |
# >> |         ８五飛車戦法 | 20   |
# >> |       一手損角換わり | 19   |
# >> |         丸山ワクチン | 19   |
# >> |               都成流 | 19   |
# >> |       角交換振り飛車 | 19   |
# >> |             稲庭戦法 | 12   |
# >> |                 風車 | 11   |
# >> |         ツノ銀中飛車 | 11   |
# >> |         一間飛車穴熊 | 10   |
# >> |           トマホーク | 8    |
# >> |             筋違い角 | 7    |
# >> |                 棒金 | 7    |
# >> |         △４五角戦法 | 5    |
# >> |             一間飛車 | 2    |
# >> |           地下鉄飛車 | 1    |
# >> |----------------------+------|
