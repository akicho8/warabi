require "./example_helper"

SkillGroupInfo.each do |e|
  puts "-" * 80 + " " + e.model.name
  e.model.each do |e|
    if e.root?
      puts e.to_s_tree
    end
  end
end
# >> -------------------------------------------------------------------------------- Bushido::DefenseInfo
# >> カニ囲い
# >> 金矢倉
# >> ├─総矢倉
# >> └─菱矢倉
# >> 銀矢倉
# >> 片矢倉
# >> 矢倉穴熊
# >> 菊水穴熊
# >> 銀立ち矢倉
# >> 雁木囲い
# >> ボナンザ囲い
# >> 銀冠
# >> 木村美濃
# >> 片美濃囲い
# >> ├─美濃囲い
# >> │   └─ダイヤモンド美濃
# >> ├─高美濃囲い
# >> └─銀美濃
# >> ちょんまげ美濃
# >> 坊主美濃
# >> 左美濃
# >> 天守閣美濃
# >> 四枚美濃
# >> 端玉銀冠
# >> 串カツ囲い
# >> 舟囲い
# >> 居飛車穴熊
# >> 松尾流穴熊
# >> 銀冠穴熊
# >> ビッグ４
# >> 箱入り娘
# >> ミレニアム囲い
# >> 振り飛車穴熊
# >> 右矢倉
# >> 金無双
# >> 中住まい
# >> 中原玉
# >> アヒル囲い
# >> いちご囲い
# >> -------------------------------------------------------------------------------- Bushido::AttackInfo
# >> ３七銀戦法
# >> 脇システム
# >> 矢倉棒銀
# >> 森下システム
# >> 雀刺し
# >> 米長流急戦矢倉
# >> カニカニ銀
# >> 中原流急戦矢倉
# >> 阿久津流急戦矢倉
# >> 矢倉中飛車
# >> 右四間飛車
# >> 原始棒銀
# >> 右玉
# >> かまいたち戦法
# >> パックマン戦法
# >> 新米長玉
# >> 稲庭戦法
# >> 四手角
# >> 角換わり
# >> 角換わり腰掛け銀
# >> 角換わり早繰り銀
# >> 筋違い角
# >> 木村定跡
# >> 一手損角換わり
# >> 相掛かり
# >> 相掛かり棒銀
# >> 塚田スペシャル
# >> 中原流相掛かり
# >> 中原飛車
# >> 腰掛け銀
# >> 鎖鎌銀
# >> ８五飛車戦法
# >> 横歩取り
# >> △３三角型空中戦法
# >> △３三桂戦法
# >> △４五角戦法
# >> 相横歩取り
# >> ゴキゲン中飛車
# >> ツノ銀中飛車
# >> 平目
# >> 風車
# >> 新風車
# >> 英ちゃん流中飛車
# >> 原始中飛車
# >> 加藤流袖飛車
# >> ５七金戦法
# >> 超急戦
# >> 四間飛車
# >> 藤井システム
# >> 立石流
# >> レグスペ
# >> 三間飛車
# >> 石田流
# >> 早石田
# >> 升田式石田流
# >> 鬼殺し
# >> △３ニ飛戦法
# >> 中田功ＸＰ
# >> 真部流
# >> ▲７八飛戦法
# >> ４→３戦法
# >> 楠本式石田流
# >> 新石田流
# >> 新鬼殺し
# >> ダイレクト向かい飛車
# >> 向飛車
# >> メリケン向かい飛車
# >> 阪田流向飛車
# >> 角頭歩戦法
# >> 鬼殺し向かい飛車
# >> 陽動振り飛車
# >> つくつくぼうし戦法
# >> 相振り飛車
# >> ポンポン桂
# >> ５筋位取り
# >> 玉頭位取り
# >> 地下鉄飛車
# >> 飯島流引き角戦法
# >> 丸山ワクチン
# >> ４六銀左急戦
# >> ４五歩早仕掛け
# >> 鷺宮定跡
# >> ４六銀右急戦
# >> 左美濃急戦
# >> 右四間飛車急戦
# >> 鳥刺し
# >> 嬉野流
# >> 棒金
# >> 超速
