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
    {
      :title => "2筋の取り合い",
      # :execute => "▲２六歩 △２四歩 ▲２五歩 △同歩 ▲同飛",
      :execute => "▲２六歩 △２四歩 ▲２五歩 △同歩",
      :tags => "test",
      :board => :default,
    },
  ]

  if $0 == __FILE__
    frame = LiveFrame2.new(EffectivePatterns.last)
    frame.to_all_frames{|f|
      p f
      p f.ki2_logs
    }
    p frame
    p frame.ki2_logs
  end
end
