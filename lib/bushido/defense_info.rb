# frozen-string-literal: true

require_relative "teaiwari_info"
require "tree_support"

module Bushido
  class DefenseInfo
    include ApplicationMemoryRecord
    memory_record [
      {wars_code: "000",  key: "カニ囲い",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-88.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kanigakoi.html",            },
      {wars_code: "001",  key: "金矢倉",           parent: nil,          alias_names: "矢倉囲い", turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "基本的な囲い",       sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-89.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kinyagura.html",            },
      {wars_code: "002",  key: "銀矢倉",           parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-90.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/ginyagura.html",            },
      {wars_code: "003",  key: "片矢倉",           parent: nil,          alias_names: "天野矢倉", turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-91.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/katayagura.html",           },
      {wars_code: "004",  key: "総矢倉",           parent: "金矢倉",     alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-92.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/souyagura.html",            },
      {wars_code: "005",  key: "矢倉穴熊",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-93.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/yaguraanaguma.html",        },
      {wars_code: "006",  key: "菊水穴熊",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-94.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kikusuiyagura.html",        },
      {wars_code: "007",  key: "銀立ち矢倉",       parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-95.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/gindatiyagura.html",        },
      {wars_code: "008",  key: "菱矢倉",           parent: "金矢倉",     alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-96.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/hisiyagura.html",           },
      {wars_code: "009",  key: "雁木囲い",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "その他の囲い",       sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-97.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/ganngi.html",               },
      {wars_code: "010",  key: "ボナンザ囲い",     parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "その他の囲い",       sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-98.html",  siratama_url: nil,                                                                                     },
      {wars_code: "100",  key: "美濃囲い",         parent: "片美濃囲い", alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-99.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/minokakoi.html",         },
      {wars_code: "101",  key: "高美濃囲い",       parent: "片美濃囲い", alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-99.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/takaminokakoi.html",     },
      {wars_code: "102",  key: "銀冠",             parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-101.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/ginkannmuri.html",       },
      {wars_code: "103",  key: "銀美濃",           parent: "片美濃囲い", alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-102.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/ginmino.html",           },
      {wars_code: "104",  key: "ダイヤモンド美濃", parent: "美濃囲い",   alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-103.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/daiyamondomino.html",    },
      {wars_code: "105",  key: "木村美濃",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-104.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/kimuramino.html",        },
      {wars_code: "106",  key: "片美濃囲い",       parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-105.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/kataminokakoi.html",     },
      {wars_code: "107",  key: "ちょんまげ美濃",   parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-106.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/tyonmagemino.html",      },
      {wars_code: "108",  key: "坊主美濃",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-107.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/tyonmagemino.html",      },
      {wars_code: "200",  key: "左美濃",           parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-108.html", siratama_url: nil,                                                                                     },
      {wars_code: "201",  key: "天守閣美濃",       parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-109.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/tennsyukakumino.html",      },
      {wars_code: "202",  key: "四枚美濃",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-110.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/yonmaimino.html",        },
      {wars_code: "203",  key: "端玉銀冠",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "美濃囲い変化形",     sankou_url: "http://mudasure.com/blog-entry-26.html",               siratama_url: nil,      },
      {wars_code: "204",  key: "串カツ囲い",       parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "穴熊変化形",         sankou_url: "http://mudasure.com/blog-entry-27.html",               siratama_url: nil,        },
      {wars_code: "300",  key: "舟囲い",           parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "基本的な囲い",       sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-111.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/funagakoi.html",            },
      {wars_code: "301",  key: "居飛車穴熊",       parent: nil,          alias_names: "イビ穴",   turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "基本的な囲い",       sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-112.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/anaguma.html",              },
      {wars_code: "302",  key: "松尾流穴熊",       parent: "居飛車穴熊", alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "穴熊変化形",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-113.html", siratama_url: nil,                                                                                     },
      {wars_code: "303",  key: "銀冠穴熊",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "穴熊変化形",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-114.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/ginkanmurianaguma.html", },
      {wars_code: "304",  key: "ビッグ４",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "穴熊変化形",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-115.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/big4.html",                 },
      {wars_code: "305",  key: "箱入り娘",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "穴熊変化形",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-116.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/hakoirimusume.html",        },
      {wars_code: "306",  key: "ミレニアム囲い",   parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "穴熊変化形",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-117.html", siratama_url: nil,                                                                                     },
      {wars_code: "400",  key: "振り飛車穴熊",     parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "穴熊変化形",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-118.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/anaguma.html",           },
      {wars_code: "401",  key: "右矢倉",           parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "矢倉変化系",         sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-119.html", siratama_url: nil,                                                                                     },
      {wars_code: "402",  key: "金無双",           parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "振り飛車", defense_group_info: "基本的な囲い",       sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-120.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/kinmusou.html",          },
      {wars_code: "403",  key: "中住まい",         parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "自陣全体を守る囲い", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-121.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/nakazumai.html",            },
      {wars_code: "404",  key: "中原玉",           parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "自陣全体を守る囲い", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-122.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/nakaharagakoi.html",        },
      {wars_code: "500",  key: "アヒル囲い",       parent: nil,          alias_names: "金開き",   turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "自陣全体を守る囲い", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-123.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kinnbiraki.html",           },
      {wars_code: "501",  key: "いちご囲い",       parent: nil,          alias_names: nil,        turn_limit: nil, turn_eq: nil, compare_my_side_only: true, compare_condition: :include, teban_eq: nil, fuganai: false, kill_only: nil, stroke_only: nil, gentei_match_any: nil, kaisenmae: nil, hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_count_eq: nil, hold_piece_eq: nil, triggers: nil,  sect_key: "居飛車",   defense_group_info: "その他の囲い",       sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-124.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/ichigogakoi.html",          },
    ]

    include TeaiwariInfo::DelegateToShapeInfoMethods

    concerning :AttackInfoSharedMethods do
      included do
        include TreeSupport::Treeable
        include TreeSupport::Stringify
      end

      class_methods do
        def lookup(v)
          super || other_table[v]
        end

        private

        def other_table
          @other_table ||= inject({}) do |a, e|
            e.alias_names.inject(a) do |a, v|
              a.merge(v => e)
            end
          end
        end
      end

      def parent
        if super
          @parent ||= self.class.fetch(super)
        end
      end

      def children
        @children ||= self.class.find_all { |e| e.parent == self }
      end

      def cached_descendants
        @cached_descendants ||= descendants
      end

      def alias_names
        Array(super)
      end

      def sect_info
        SectInfo.fetch(sect_key)
      end

      def triggers
        if super
          Array(super).collect do |e|
            Soldier.from_str(e)
          end
        end
      end

      def hold_piece_eq
        if super
          Utils.hold_pieces_s_to_a(super)
        end
      end

      def hold_piece_in
        if super
          Utils.hold_pieces_s_to_a(super)
        end
      end

      def hold_piece_not_in
        if super
          Utils.hold_pieces_s_to_a(super)
        end
      end

      def gentei_match_any
        if super
          Array(super).collect do |e|
            Soldier.from_str(e)
          end
        end
      end

      # def self_check
      #   if process_ki2
      #     info = Parser.parse(process_ki2)
      #     names = info.mediator.players.flat_map do |e|
      #       (e.defense_infos + e.attack_infos).collect(&:name)
      #     end
      #     if names.include?(name)
      #       names
      #     end
      #   end
      # end
    end
  end
end
