# frozen-string-literal: true
module Bushido
  class TeaiwariInfo
    include ApplicationMemoryRecord
    memory_record [
      {
        key: "平手",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
EOT
      },
      {
        key: "香落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
| ・ 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
EOT
      },
      {
        key: "右香落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
| 香 桂 銀 金 玉 金 銀 桂 ・|九
+---------------------------+
EOT
      },
      {
        key: "角落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ 飛 ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
EOT
      },
      {
        key: "飛車落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ ・ ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
EOT
      },
      {
        key: "飛車香落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ ・ ・|八
| ・ 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
EOT
      },
      {
        key: "二枚落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
EOT
      },

      # 開始日時：1849/03/15
      # 棋戦：その他の棋戦
      # 戦型：その他の戦型
      # 手合割：三枚落ち
      # 上手：伊藤宗印
      # 下手：天満屋
      {
        key: "三枚落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
EOT
      },
      {
        key: "四枚落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ 桂 銀 金 玉 金 銀 桂 ・|九
+---------------------------+
EOT
      },
      {
        key: "六枚落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ 銀 金 玉 金 銀 ・ ・|九
+---------------------------+
EOT
      },
      {
        key: "八枚落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ 金 玉 金 ・ ・ ・|九
+---------------------------+
EOT
      },
      {
        key: "十枚落ち",
        board_body: <<~EOT,
+---------------------------+
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ 玉 ・ ・ ・ ・|九
+---------------------------+
EOT
      },
      {
        key: "十九枚落ち",
        board_body: <<~EOT,
+---------------------------+
| ・ ・ ・ ・ 玉 ・ ・ ・ ・|九
+---------------------------+
EOT
      },
      {
        key: "二十枚落ち",
        board_body: <<~EOT,
+---------------------------+
+---------------------------+
EOT
      },
    ]

    class << self
      def lookup(key)
        # 「飛車落ち」と「飛落ち」を同一判定したいため
        key = key.to_s
        key = key.gsub(/飛落/, "飛車落")
        key = key.gsub(/飛香/, "飛車香")
        key = key.gsub(/香車/, "香")
        super
      end
    end

    concerning :BasicMethods do
      # 基本これを使う
      def board_parser
        @board_parser ||= BoardParser.parse(board_body)
      end

      def both_board_info
        @both_board_info ||= board_parser.both_board_info
      end

      def sorted_black_side_mini_soldiers
        @sorted_black_side_mini_soldiers ||= black_side_mini_soldiers.sort
      end

      def black_side_mini_soldiers
        @black_side_mini_soldiers ||= both_board_info[Location[:black]]
      end
    end

    def name
      key.to_s
    end
  end
end