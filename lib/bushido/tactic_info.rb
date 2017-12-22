module Bushido
  class TacticInfo
    include ApplicationMemoryRecord
    memory_record [
      {key: :defense, name: "囲い"},
      {key: :attack,  name: "戦型"},
    ]

    def model
      "bushido/#{key}_info".classify.constantize
    end

    def var_key
      "#{key}_infos"
    end

    class << self
      def all_elements
        @all_elements ||= flat_map { |e| e.model.to_a }
      end

      # トリガーがある場合はそれだけ登録すればよくて
      # 登録がないものはすべてをトリガーキーと見なす
      def soldier_hash_table
        @soldier_hash_table ||= all_elements.each_with_object({}) do |e, m|
          e.board_parser.primary_soldiers.each do |s|
            # soldier 自体をキーにすればほどよく分散できる
            m[s] ||= []
            m[s] << e
          end
        end
      end
    end
  end
end