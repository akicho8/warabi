# -*- coding: utf-8 -*-
Bushido::BoardLibs = {
  "平手" => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|    角                飛   |八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  "香落ち" => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|    角                飛   |八
|    桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  "角落ち" => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|                      飛   |八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  "両落ち" => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|                           |八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  "玉のみ" => <<-BOARD,
+---------------------------+
|             玉            |九
+---------------------------+
BOARD
  "全落ち" => <<-BOARD,
+---------------------------+
+---------------------------+
BOARD
}
