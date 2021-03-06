require_relative "../../../bioshogi"

module Bioshogi
  XtraPattern.define do
    [
      {
        title: Pathname(__FILE__).basename(".*"),
        notation_dsl: lambda do
          board "平手"
          auto_flushing {
            set :hide_to_ki2_a, true
            mov "▲７六歩(77) △３四歩(33) ▲２六歩(27) △８四歩(83) ▲７八金(69) △８五歩(84) ▲２二角成(88) △同銀(31) ▲８八銀(79) △７二銀(71) ▲３八銀(39) △３二金(41) ▲７七銀(88) △６四歩(63) ▲９六歩(97) △６三銀(72) ▲９五歩(96) △４二王(51) ▲４六歩(47) △７四歩(73) ▲６八王(59) △７三桂(81) ▲４七銀(38) △３三銀(22) ▲５八金(49) △３一王(42) ▲５六銀(47) △５四銀(63) ▲７九王(68) △２二王(31) ▲３六歩(37) △５二金(61) ▲３七桂(29) △６五桂(73) ▲６八銀(77) △８六歩(85) ▲同歩(87) △同飛(82) ▲８七歩打 △７六飛(86) ▲６六歩(67) △同飛(76) ▲６七銀(68) △４四角打 ▲８八角打 △５六飛(66) ▲同歩(57) △８八角成(44) ▲同王(79) △４四角打 ▲９八王(88) △６九銀打 ▲６八金(58) △７八銀(69) ▲同金(68) △５七桂成(65) ▲７六銀(67) △７五歩(74) ▲８五銀(76) △６七金打 ▲８八金(78) △４二金(52) ▲７一飛打 △５六成桂(57) ▲９一飛成(71) △８四歩打 ▲同銀(85) △７六歩(75) ▲７八歩打 △６六角(44) ▲５一角打 △４一金(42) ▲６二角成(51) △４二金(41) ▲５一馬(62) △３九角成(66) ▲１八飛(28) △６六馬(39) ▲８二竜(91) △８六歩打 ▲３五歩(36) △８七歩成(86) ▲同金(88) △１二王(22) ▲３四歩(35) △同銀(33) ▲４二馬(51) △同金(32) ▲同竜(82) △２二角打 ▲３一銀打 △３二歩打 ▲３三歩打 △同馬(66) ▲同竜(42) △同桂(21) ▲４二角打 △２一飛打 ▲２二銀成(31) △同飛(21) ▲３一角打 △２一銀打 ▲３六香打 △８六歩打 ▲同金(87) △８五歩打 ▲同金(86) △７七歩成(76) ▲同歩(78) △８六歩打 ▲３四香(36) △８七歩成(86) ▲同王(98)"
          }
        end,
      },
    ]
  end

  if $0 == __FILE__
    # XtraPattern.each{|pattern|HybridSequencer.execute(pattern)}
    HybridSequencer.execute(XtraPattern.list.last).each{|frame|
      puts frame.to_text
    }
  end
end
