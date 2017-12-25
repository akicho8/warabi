require "./example_helper"

info = Parser.parse(<<~EOT)
開始日時：2004/05/29
棋戦：その他の棋戦
戦型：中飛車
手合割：角落ち
下手：今井　進
上手：古河彩子

*棋戦詳細：プロアマ指導対局
*「今井進ミステリマガジン編集長（自称四段）」vs「古河彩子女流二段」
EOT

tp info.header.to_h
tp info.header.to_names_h
tp info.header.meta_info
tp info.header.to_meta_h
tp info.header.to_kisen_a
tp info.header.to_simple_names_h
# >> |----------+------------------|
# >> | 開始日時 | 2004/05/29       |
# >> |     棋戦 | その他の棋戦     |
# >> |     戦型 | 中飛車           |
# >> |   手合割 | 角落ち           |
# >> |     下手 | 今井 進          |
# >> |     上手 | 古河彩子         |
# >> | 棋戦詳細 | プロアマ指導対局 |
# >> |----------+------------------|
# >> |----------+----------------------------------------------------------|
# >> | 下手詳細 | ["今井進", "ミステリマガジン", "編集長", "自称", "四段"] |
# >> | 上手詳細 | ["古河彩子", "女流", "二段"]                             |
# >> |----------+----------------------------------------------------------|
# >> |----------+------------------------------------------|
# >> | 下手詳細 | 今井進ミステリマガジン編集長（自称四段） |
# >> | 上手詳細 | 古河彩子女流二段                         |
# >> |----------+------------------------------------------|
# >> |----------+----------------------------------------------------------|
# >> | 開始日時 | 2004/05/29                                               |
# >> |     棋戦 | その他の棋戦                                             |
# >> |     戦型 | 中飛車                                                   |
# >> |   手合割 | 角落ち                                                   |
# >> |     下手 | 今井 進                                                  |
# >> |     上手 | 古河彩子                                                 |
# >> | 棋戦詳細 | ["プロ", "アマ", "指導対局"]                             |
# >> | 下手詳細 | ["今井進", "ミステリマガジン", "編集長", "自称", "四段"] |
# >> | 上手詳細 | ["古河彩子", "女流", "二段"]                             |
# >> |----------+----------------------------------------------------------|
# >> |----------|
# >> | プロ     |
# >> | アマ     |
# >> | 指導対局 |
# >> |----------|
# >> |------+--------------|
# >> | 下手 | ["今井 進"]  |
# >> | 上手 | ["古河彩子"] |
# >> |------+--------------|
