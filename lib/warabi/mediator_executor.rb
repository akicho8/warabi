# frozen-string-literal: true

module Warabi
  concern :MediatorExecutor do
    included do
      attr_accessor :kill_counter
    end

    def initialize(*)
      super

      @kill_counter = 0
    end

    def hand_logs
      @hand_logs ||= []
    end

    # 棋譜入力
    def execute(str)
      Array.wrap(str).each do |str|

        # ▲△があれば見て手番と一致しているか確認する
        # なければチェックしなくていい
        if true
          if md = InputParser.match!(str)
            if key = md[:triangle] || md[:sign]
              location = Location.fetch(key)
              if current_player.location != location
                raise DifferentTurnError, "#{current_player.call_name}番で#{flip_player.call_name}が着手しました : #{str}"
              end
            end
          end
        end

        current_player.execute(str)
        turn_info.counter += 1
      end
    end

    # 互換性用
    if true
      def kif_hand_logs; hand_logs.collect { |e| e.to_kif(with_mark: false) }; end
      def ki2_hand_logs; hand_logs.collect { |e| e.to_ki2(with_mark: true) }; end
    end
  end
end
