# -*- coding: utf-8 -*-
Bushido::StaticBoard = [
  {
    :key => "平手",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  {
    :key => "香落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
| ・ 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  {
    :key => "角落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ 飛 ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  {
    :key => "飛車落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ ・ ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  {
    :key => "飛車香落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ ・ ・|八
| ・ 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  {
    :key => "二枚落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
BOARD
  },
  {
    :key => "四枚落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ 桂 銀 金 玉 金 銀 桂 ・|九
+---------------------------+
BOARD
  },
  {
    :key => "六枚落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ 銀 金 玉 金 銀 ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "八枚落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ 金 玉 金 ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "十枚落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ 玉 ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "十九枚落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ 玉 ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "裸玉",
    :defense_p => false,
    :url => "http://ja.wikipedia.org/wiki/%E5%B0%86%E6%A3%8B%E3%81%AE%E6%89%8B%E5%90%88%E5%89%B2",
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ 玉 ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "二十枚落ち",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
+---------------------------+
BOARD
  },
  {
    :key => "なし",
    :defense_p => false,
    :board => <<-BOARD,
+---------------------------+
+---------------------------+
BOARD
  },
  {
    :key => "カニ囲い",
    :shogi_wars_code => "000",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-88.html",
    :url => "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kanigakoi.html",
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
  {
    :key => "金矢倉",
    :shogi_wars_code => "001",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-89.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 金 ・ ・ ・ ・ ・|七
| ・ 玉 金 ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "銀矢倉",
    :shogi_wars_code => "002",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-90.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 銀 ・ ・ ・ ・ ・|七
| ・ 玉 金 ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "片矢倉",
    :shogi_wars_code => "003",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-91.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 金 ・ ・ ・ ・ ・|七
| ・ ・ 玉 金 ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "総矢倉",
    :shogi_wars_code => "004",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-92.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 金 銀 ・ ・ ・ ・|七
| ・ 玉 金 ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "矢倉穴熊",
    :shogi_wars_code => "005",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-93.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 金 ・ ・ ・ ・ ・|七
| 香 ・ 金 ・ ・ ・ ・ ・ ・|八
| 玉 ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "菊水穴熊",
    :shogi_wars_code => "006",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-94.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ 金 ・ ・ ・ ・ ・|七
| ・ 銀 金 ・ ・ ・ ・ ・ ・|八
| 香 玉 ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "銀立ち矢倉",
    :shogi_wars_code => "007",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-95.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ 金 ・ ・ ・ ・ ・|七
| ・ 玉 金 ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "菱矢倉",
    :shogi_wars_code => "008",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-96.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ 銀 ・ ・ ・ ・ ・|六
| ・ ・ 銀 金 ・ ・ ・ ・ ・|七
| ・ 玉 金 ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "雁木囲い",
    :shogi_wars_code => "009",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-97.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ 銀 銀 ・ ・ ・ ・|七
| ・ ・ 金 ・ 金 ・ ・ ・ ・|八
| ・ ・ ・ 玉 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "ボナンザ囲い",
    :shogi_wars_code => "010",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-98.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 ・ ・ ・ ・ ・ ・|七
| ・ ・ 玉 金 金 ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "美濃囲い",
    :shogi_wars_code => "100",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-99.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ 歩 ・|七
| ・ ・ ・ ・ 金 ・ 銀 玉 ・|八
| ・ ・ ・ ・ ・ 金 ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "高美濃囲い",
    :shogi_wars_code => "101",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-99.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ 金 ・ 歩 ・|七
| ・ ・ ・ ・ ・ ・ 銀 玉 ・|八
| ・ ・ ・ ・ ・ 金 ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "銀冠",
    :shogi_wars_code => "102",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-101.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ 金 ・|七
| ・ ・ ・ ・ ・ ・ 銀 玉 ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "銀美濃",
    :shogi_wars_code => "103",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-102.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ 銀 ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ 銀 玉 ・|八
| ・ ・ ・ ・ ・ 金 ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "ダイヤモンド美濃",
    :shogi_wars_code => "104",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-103.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ 銀 ・ ・ ・|七
| ・ ・ ・ ・ 金 ・ 銀 玉 ・|八
| ・ ・ ・ ・ ・ 金 ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "木村美濃",
    :shogi_wars_code => "105",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-104.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ 銀 ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ 金 玉 ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "片美濃囲い",
    :shogi_wars_code => "106",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-105.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ 歩 ・|七
| ・ ・ ・ ・ ・ ・ 銀 玉 ・|八
| ・ ・ ・ ・ ・ 金 ・ ・ ・|九
+---------------------------+
BOARD
  },

  {
    :key => "ちょんまげ美濃",
    :shogi_wars_code => "107",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-106.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ 歩 ・|六
| ・ ・ ・ ・ ・ ・ 歩 ・ ・|七
| ・ ・ ・ ・ ・ ・ 銀 玉 ・|八
| ・ ・ ・ ・ ・ 金 ・ ・ ・|九
+---------------------------+
BOARD
  },
#   {
#     :key => "坊主美濃",
#     :shogi_wars_code => "108",
#     :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-107.html",
#     :defense_p => true,
#     :board => <<-BOARD,
# +---------------------------+
# | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
# | ・ ・ ・ ・ ・ ・ 歩 ・ ・|七
# | ・ ・ ・ ・ ・ ・ 銀 玉 ・|八
# | ・ ・ ・ ・ ・ 金 ・ ・ ・|九
# +---------------------------+
# BOARD
#   },
  {
    :key => "左美濃",
    :shogi_wars_code => "200",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-108.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ 玉 銀 ・ 金 ・ ・ ・ ・|八
| ・ ・ ・ 金 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "天守閣美濃",
    :shogi_wars_code => "201",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-109.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 歩 ・ ・ ・ ・ ・ ・|六
| ・ 玉 ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ 銀 ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ 金 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "四枚美濃",
    :shogi_wars_code => "202",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-110.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ 玉 銀 金 ・ ・ ・ ・ ・|七
| ・ ・ 銀 ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ 金 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "舟囲い",
    :shogi_wars_code => "300",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-111.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 歩 ・ 歩 ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ 玉 ・ 金 銀 ・ ・ ・|八
| ・ ・ 銀 金 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "居飛車穴熊",
    :shogi_wars_code => "301",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-112.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| 香 銀 ・ ・ ・ ・ ・ ・ ・|八
| 玉 桂 金 ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "松尾流穴熊",
    :shogi_wars_code => "302",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-113.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ 金 ・ ・ ・ ・ ・|七
| 香 銀 金 ・ ・ ・ ・ ・ ・|八
| 玉 桂 銀 ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "銀冠穴熊",
    :shogi_wars_code => "303",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-114.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 歩 ・ ・ ・ ・ ・ ・|六
| ・ 銀 ・ ・ ・ ・ ・ ・ ・|七
| 香 ・ 金 ・ ・ ・ ・ ・ ・|八
| 玉 桂 ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "ビッグ４",
    :shogi_wars_code => "304",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-115.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ 銀 銀 ・ ・ ・ ・ ・ ・|七
| 香 金 金 ・ ・ ・ ・ ・ ・|八
| 玉 桂 ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "箱入り娘",
    :shogi_wars_code => "305",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-116.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 玉 金 ・ ・ ・ ・ ・|八
| ・ ・ 銀 金 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "ミレニアム囲い",
    :shogi_wars_code => "306",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-117.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ 銀 ・ ・ ・ ・ ・ ・ ・|八
| ・ 玉 金 ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "振り飛車穴熊",
    :shogi_wars_code => "400",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-118.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ 銀 香|八
| ・ ・ ・ ・ ・ ・ 金 桂 玉|九
+---------------------------+
BOARD
  },
  {
    :key => "右矢倉",
    :shogi_wars_code => "401",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-119.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ 銀 ・ ・|七
| ・ ・ ・ ・ ・ ・ 金 玉 ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "金無双",
    :shogi_wars_code => "402",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-120.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ 金 金 玉 銀 ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "中住まい",
    :shogi_wars_code => "403",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-121.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ 金 ・ 玉 銀 金 ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "中原玉",
    :shogi_wars_code => "404",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-122.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ 銀 金 ・ ・ 銀 ・ ・ ・|八
| ・ ・ ・ 玉 金 ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "アヒル囲い",
    :shogi_wars_code => "500",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-123.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ 銀 玉 銀 ・ ・ ・|八
| ・ ・ 金 ・ ・ ・ 金 ・ ・|九
+---------------------------+
BOARD
  },

  {
    :key => "いちご囲い",
    :shogi_wars_code => "501",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-124.html",
    :defense_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 歩 ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ 金 玉 金 ・ ・ ・ ・|八
| ・ ・ 銀 ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  # --------------------------------------------------------------------------------

  {
    :key => "３七銀戦法",
    :shogi_wars_code => "2000",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-139.html",
    :attack_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 ・ ・ ・ 銀 ・ ・|七
| ・ ・ 金 ・ ・ ・ ・ 飛 ・|八
| ・ ・ ・ 玉 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },

# 相手の駒も関係してくるので定義が難しい
#   {
#     :key => "脇システム",
#     :shogi_wars_code => "2001",
#     :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-159.html",
#     :attack_p => true,
#     :not_same => true,
#     :board => <<-BOARD,
# +---------------------------+
# | ・ ・ ・v角 ・ ・ ・ ・ ・|四
# | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# | ・ ・ ・ ・ ・ 角 ・ ・ ・|六
# | ・ ・ 銀 金 ・ ・ 銀 ・ ・|七
# | ・ 玉 金 ・ ・ ・ ・ ・ ・|八
# | ・ ・ ・ ・ ・ ・ ・ ・ ・|九
# +---------------------------+
# BOARD
#   },

  {
    :key => "３七銀戦法",
    :shogi_wars_code => "2000",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-139.html",
    :attack_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ 銀 ・ ・ ・ 銀 ・ ・|七
| ・ ・ 金 ・ ・ ・ ・ 飛 ・|八
| ・ ・ ・ 玉 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "森下システム",
    :shogi_wars_code => "2003",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-150.html",
    :attack_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ 桂 ・ ・|七
| ・ ・ 金 ・ 金 銀 飛 ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "雀刺し",
    :shogi_wars_code => "2004",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-149.html",
    :attack_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ 香|七
| ・ ・ 金 ・ 金 ・ ・ ・ 飛|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
  {
    :key => "米長流急戦矢倉",
    :shogi_wars_code => "2005",
    :form_check_url => "http://mijinko83.blog110.fc2.com/blog-entry-147.html",
    :attack_p => true,
    :board => <<-BOARD,
+---------------------------+
| ・ ・ ・ 銀 歩 ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ 角 金 ・ 金 ・ ・ ・ ・|八
| ・ ・ ・ 玉 ・ ・ ・ ・ ・|九
+---------------------------+
BOARD
  },
]
