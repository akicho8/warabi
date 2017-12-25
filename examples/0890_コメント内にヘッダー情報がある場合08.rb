require "./example_helper"

info = Parser.parse(<<~EOT)
開始日時：2010/10/28 10:00
終了日時：2010/10/28 17:37
棋戦：マイナビ
戦型：中飛車
消費時間：171▲180△180
先手：石橋幸緒女流四段
後手：中倉宏美女流二段

場所：東京都「ＬＰＳＡ芝浦対局場」
持ち時間：3時間
*棋戦詳細：第4期マイナビ女子オープン本戦1回戦第8局
*「石橋幸緒女流四段」vs「中倉宏美女流二段」
EOT

tp info.header.to_h
tp info.header.to_names_h
tp info.header.meta_info
tp info.header.to_meta_h
tp info.header.to_kisen_a
tp info.header.to_simple_names_h
# >> |----------+-----------------------------------------|
# >> | 開始日時 | 2010/10/28 10:00:00                     |
# >> | 終了日時 | 2010/10/28 17:37:00                     |
# >> |     棋戦 | マイナビ                                |
# >> |     戦型 | 中飛車                                  |
# >> | 消費時間 | 171▲180△180                           |
# >> |     先手 | 石橋幸緒女流四段                        |
# >> |     後手 | 中倉宏美女流二段                        |
# >> |     場所 | 東京都「LPSA芝浦対局場」                |
# >> | 持ち時間 | 3時間                                   |
# >> | 棋戦詳細 | 第4期マイナビ女子オープン本戦1回戦第8局 |
# >> |----------+-----------------------------------------|
# >> |----------+------------------------------|
# >> | 先手詳細 | ["石橋幸緒", "女流", "四段"] |
# >> | 後手詳細 | ["中倉宏美", "女流", "二段"] |
# >> |----------+------------------------------|
# >> |----------+------------------|
# >> | 先手詳細 | 石橋幸緒女流四段 |
# >> | 後手詳細 | 中倉宏美女流二段 |
# >> |----------+------------------|
# >> |----------+-------------------------------------------------------------|
# >> | 開始日時 | 2010/10/28 10:00:00                                         |
# >> | 終了日時 | 2010/10/28 17:37:00                                         |
# >> |     棋戦 | マイナビ                                                    |
# >> |     戦型 | 中飛車                                                      |
# >> | 消費時間 | 171▲180△180                                               |
# >> |     先手 | 石橋幸緒女流四段                                            |
# >> |     後手 | 中倉宏美女流二段                                            |
# >> |     場所 | 東京都「LPSA芝浦対局場」                                    |
# >> | 持ち時間 | 3時間                                                       |
# >> | 棋戦詳細 | ["第4期", "マイナビ女子オープン", "本戦", "1回戦", "第8局"] |
# >> | 先手詳細 | ["石橋幸緒", "女流", "四段"]                                |
# >> | 後手詳細 | ["中倉宏美", "女流", "二段"]                                |
# >> |----------+-------------------------------------------------------------|
# >> |----------------------|
# >> | 第4期                |
# >> | マイナビ女子オープン |
# >> | 本戦                 |
# >> | 1回戦                |
# >> | 第8局                |
# >> |----------------------|
# >> |------+----------------------|
# >> | 先手 | ["石橋幸緒女流四段"] |
# >> | 後手 | ["中倉宏美女流二段"] |
# >> |------+----------------------|
