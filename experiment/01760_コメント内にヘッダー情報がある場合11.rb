require "./example_helper"

info = Parser.parse(<<~EOT)
開始日時：2003/11/09
棋戦：赤旗名人戦
戦型：角交換その他
備考：４手目△３三角△中飛車
先手：吉田正和
後手：村田登亀雄

場所：東京都池袋「ホテルグランドヘイツ」
持ち時間：45分
*棋戦詳細：第41回赤旗名人戦決勝
*「吉田正和（17歳、埼玉）」vs「村田登亀雄（39歳、前回優勝)」
EOT

tp info.header.to_h
tp info.header.__to_simple_names_h
tp info.header.meta_info
tp info.header.__to_meta_h
tp info.header.to_kisen_a
tp info.header.__to_simple_names_h
# >> |----------+------------------------------------|
# >> | 開始日時 | 2003/11/09                         |
# >> |     棋戦 | 赤旗名人戦                         |
# >> |     戦型 | 角交換その他                       |
# >> |     備考 | 4手目△3三角△中飛車               |
# >> |     先手 | 吉田正和                           |
# >> |     後手 | 村田登亀雄                         |
# >> |     場所 | 東京都池袋「ホテルグランドヘイツ」 |
# >> | 持ち時間 | 45分                               |
# >> | 棋戦詳細 | 第41回赤旗名人戦決勝               |
# >> | 先手詳細 | 吉田正和(17歳、埼玉)               |
# >> | 後手詳細 | 村田登亀雄(39歳、前回優勝)         |
# >> |----------+------------------------------------|
# >> |----------+----------------------------------------|
# >> | 先手詳細 | ["吉田正和", "17歳", "埼玉"]           |
# >> | 後手詳細 | ["村田登亀雄", "39歳", "前回", "優勝"] |
# >> |----------+----------------------------------------|
# >> |----------+----------------------------|
# >> | 先手詳細 | 吉田正和(17歳、埼玉)       |
# >> | 後手詳細 | 村田登亀雄(39歳、前回優勝) |
# >> |----------+----------------------------|
# >> |----------+----------------------------------------|
# >> | 開始日時 | 2003/11/09                             |
# >> |     棋戦 | 赤旗名人戦                             |
# >> |     戦型 | 角交換その他                           |
# >> |     備考 | 4手目△3三角△中飛車                   |
# >> |     先手 | ["吉田正和"]                           |
# >> |     後手 | ["村田登亀雄"]                         |
# >> |     場所 | 東京都池袋「ホテルグランドヘイツ」     |
# >> | 持ち時間 | 45分                                   |
# >> | 棋戦詳細 | ["第41回", "赤旗", "名人戦", "決勝"]   |
# >> | 先手詳細 | ["吉田正和", "17歳", "埼玉"]           |
# >> | 後手詳細 | ["村田登亀雄", "39歳", "前回", "優勝"] |
# >> |----------+----------------------------------------|
# >> |--------|
# >> | 第41回 |
# >> | 赤旗   |
# >> | 名人戦 |
# >> | 決勝   |
# >> |--------|
# >> |------+----------------|
# >> | 先手 | ["吉田正和"]   |
# >> | 後手 | ["村田登亀雄"] |
# >> |------+----------------|
