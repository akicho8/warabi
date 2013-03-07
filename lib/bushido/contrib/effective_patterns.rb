# -*- coding: utf-8; compile-command: "be ruby effective_patterns.rb" -*-

require_relative "../../bushido"

module Bushido
  EffectivePatterns = [
    {
      :title => "桂と金の交換または桂成(おじいちゃんがよく使っていた技)",
      :comment => "金が逃げても３二桂成を防げない",
      :pieces => {:black => "桂"},
      :execute => "▲２四桂 △２三金 ▲３二桂成",
      :board => <<-EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|一
| ・ ・ ・ ・ ・ ・ ・v銀v金|二
| ・ ・ ・ ・ ・ ・ ・ ・ ・|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
EOT
    },
    {
      :title => "早囲い",
      :comment => "3手で組める",
      :execute => "▲４八玉 ▲３八玉 ▲４八銀",
      :board => :black,
    },
    {
      :title => "ミレニアム囲い(別名カマクラ・カマボコ・トーチカ)",
      :comment => "藤井システムに対抗する囲い",
      :execute => "▲７六歩 ▲２六歩 ▲２五歩 ▲４八銀 ▲６八玉 ▲７八玉 ▲５六歩 ▲９六歩 ▲５八金右 ▲３六歩 ▲６六角 ▲８八銀 ▲７七桂 ▲６八金寄 ▲８九玉 ▲７九金 ▲７八金寄 ▲５九銀 ▲６八銀",
      :board => :black,
    },
    {
      :title => "早石田戦法",
      :comment => "飛車先からの攻めを受けずに王手飛車(途中に説明入れたい)",
      :execute => "▲７六歩 △３四歩 ▲７五歩 △８四歩 ▲７八飛 push △８八角成 ▲同銀 △４五角 ▲７六角 △２七角成 ▲４三角成 pop △８五歩 ▲４八玉 △８六歩 ▲同歩 △同飛 ▲７四歩 △同歩 ▲２二角成 △同銀 ▲９五角",
      :board => :default,
    },
    {
      :title => "早囲いから飛車を追い返す方法",
      :comment => "いろいろ応用が効きそう",
      :url => "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/kifu/uke/furibisya/hayagakoi1.html",
      :pieces => {:black => "歩2"},
      :execute => "▲６九歩 △同龍 ▲５九金 △９九龍 ▲６九歩",
      :board => <<-EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|一
| ・ ・ ・ ・ ・ ・ ・ ・ ・|二
| ・ ・ ・ ・ ・ ・ ・ ・ ・|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ 銀 玉 ・ ・|八
|v龍 ・ ・ ・ ・ 金 ・ 桂 香|九
+---------------------------+
EOT
    },
    {
      :title => "棒銀",
      :comment => "一筋を香車で突破",
      :execute => "▲２六歩 △３四歩 ▲３八銀 △３二金 ▲２七銀 △４二銀 ▲２五歩 △３三銀 ▲２六銀 △１四歩 ▲１六歩 △６二銀 ▲１五歩 △同歩 ▲同銀 △同香 ▲同香 △１三歩 ▲１九香",
      :board => :default,
    },
    # {
    #   :title => "2筋の取り合い",
    #   :execute => "▲２六歩 △２四歩 ▲２五歩 △同歩 ▲同飛",
    #   :tags => "test",
    #   :board => :default,
    # },
    {
      :title => "銀の真下に金を打たれると厳しい",
      :pieces => {:white => "金"},
      :execute => "△５八金 ▲６八銀 △同金",
      :board => <<-EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|一
| ・ ・ ・ ・ ・ ・ ・ ・ ・|二
| ・ ・ ・ ・ ・ ・ ・ ・ ・|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・v歩 ・v歩 ・ ・ ・|五
| ・ ・ ・ ・ 歩 ・ ・ ・ ・|六
| ・ ・ ・ ・ 銀 ・ ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
EOT
    },
    {
      :title => "後手棒銀の矢倉崩し",
      :comment => "9筋の突破",
      :url => "http://home.att.ne.jp/aqua/DAIJIN/joseki/bougin10.html",
      :execute => "▲７六歩 △８四歩 ▲６八銀 △８五歩 ▲７七銀 △３四歩 ▲７八金 △４二銀 ▲４八銀 △５二金右 ▲５六歩 △５四歩 ▲２六歩 △４四歩 ▲６九玉 △４三金 ▲５八金 △３三銀 ▲６六歩 △３一角 ▲６七金右 △４二玉 ▲３六歩 △３二玉 ▲７九角 △２二玉 ▲６八角 △３二金 ▲７九玉 △９四歩 ▲９六歩 △７二銀 ▲８八玉 △８三銀 ▲２五歩 △８四銀 ▲４六歩 △９五歩 ▲同歩 △同銀 ▲同香 △同香 ▲９七歩打 △９二飛 ▲９八銀打 △９三香打 ▲４七銀 △９七香成 ▲同桂 △同香成 ▲同銀 △同角成 ▲８九玉 △９八銀打",
      :board => :default,
    },
    {
      :title => "後手の早石田対策",
      :comment => nil,
      :url => "http://home.att.ne.jp/aqua/DAIJIN/joseki/isida10.html",
      :execute => "▲７六歩 △３四歩 ▲７五歩 △８四歩 ▲７八飛 △８五歩 ▲４八玉 △６二銀 ▲７四歩 △７二金 ▲７三歩成 △同銀 ▲２二角成 △同銀 ▲５五角打 △３三角打 ▲７三角成 △同金 ▲７四歩打 △８三金 ▲７三銀打 △３二飛 ▲８八銀 △７七歩打 ▲同銀 △７四金 ▲６六銀 △７三金",
      :board => :default,
    },
    {
      :title => "新石田流の狙い",
      :comment => "TODO:解説も入力できるようにしたい",
      :url => "http://home.att.ne.jp/aqua/DAIJIN/joseki/isida14.html",
      :execute => "▲７六歩 △３四歩 ▲７五歩 △８四歩 ▲７八飛 △８五歩 ▲７四歩 △同歩 ▲同飛 △８八角成 ▲同銀 △６五角打 ▲５六角打 △７四角 ▲同角 △６二銀 ▲５五角打 △７三歩打 ▲５六角 △１二飛打 ▲３四角 △３二金 ▲５六角 △８六歩 ▲１一角成 △同飛 ▲８三香打 △７二飛 ▲８一香成 △８七歩成 ▲同銀 △８八角打 ▲８四桂打 △９九角成 ▲８三角成 △７一香打 ▲７八銀 △８八歩打 ▲７七桂 △８九歩成 ▲７二桂成 △同金 ▲同馬 △同香 ▲８二成香 △８八と ▲７二成香 △７八と ▲同金",
      :board => :default,
    },
  ]

  if $0 == __FILE__
    frame = SimulatorFrame.new(EffectivePatterns.last)
    frame.to_all_frames{|f|
      p f
      p f.humane_kif_logs
    }
    p frame
    p frame.humane_kif_logs
  end
end
