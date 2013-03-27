# -*- coding: utf-8 -*-
Bushido::BoardLibs = {
  "平手" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|    角                飛   |八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  "香落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|    角                飛   |八
|    桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  "角落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|                      飛   |八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  "飛車落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|    角                     |八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  "飛車香落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|    角                     |八
|    桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  "二枚落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|                           |八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  "四枚落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|                           |八
|    桂 銀 金 玉 金 銀 桂   |九
+---------------------------+
BOARD
  },
  "六枚落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|                           |八
|       銀 金 玉 金 銀      |九
+---------------------------+
BOARD
  },
  "八枚落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|                           |八
|          金 玉 金         |九
+---------------------------+
BOARD
  },
  "十枚落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
|                           |八
|             玉            |九
+---------------------------+
BOARD
  },
  "十九枚落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
|             玉            |九
+---------------------------+
BOARD
  },
  "裸玉" => {
    :defense_p => false,
    :url => "http://ja.wikipedia.org/wiki/%E5%B0%86%E6%A3%8B%E3%81%AE%E6%89%8B%E5%90%88%E5%89%B2",
    :board => <<-BOARD,
+---------------------------+
|             玉            |九
+---------------------------+
BOARD
  },
  "二十枚落ち" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
+---------------------------+
BOARD
  },
  "なし" => {
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
+---------------------------+
BOARD
  },
  "カニ囲い" => {
    :url => "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/ichigogakoi.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 歩 歩 歩 ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ 金 銀 金 ・ ・ ・ ・|八
| ・ ・ ・ 玉 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  "矢倉囲い" => {
    :url => "",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 歩 歩 ・ ・ ・ ・ ・|六
| ・ ・ 銀 金 ・ ・ ・ ・ ・|七
| ・ 玉 金 角 ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
}
