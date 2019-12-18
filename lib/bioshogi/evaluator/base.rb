# frozen-string-literal: true

module Bioshogi
  module Evaluator
    class Base
      attr_reader :player
      attr_reader :params

      delegate :mediator, :board, to: :player

      def self.default_params
        {}
      end

      def initialize(player, **params)
        @player = player
        @params = self.class.default_params.merge(params)
      end

      # 自分基準評価値
      def score
        Bioshogi.run_counts["#{self.class.name}#score"] += 1
        basic_score * player.location.value_sign
      end

      private

      # ▲基準評価値
      def basic_score
        score = 0
        board.surface.each_value do |e|
          score += soldier_score(e) * e.location.value_sign
        end
        mediator.players.each do |e|
          score += e.piece_box.score * e.location.value_sign
        end
        score
      end

      # 自分基準評価値
      def soldier_score(e)
        e.abs_weight
      end

      concerning :DebugMethods do
        def detail_score
          rows = []
          rows += detail_score_for(player)
          rows += detail_score_for(player.opponent_player).collect { |e| e.merge(total: -e[:total]) }
          rows + [{total: rows.collect { |e| e[:total] }.sum }]
        end

        private

        def detail_score_for(player)
          rows = player.soldiers.group_by(&:itself).transform_values(&:size).collect { |soldier, count|
            if soldier.promoted
              weight = soldier.piece.promoted_weight
            else
              weight = soldier.piece.basic_weight
            end
            {piece: soldier, count: count, weight: weight, total: weight * count}
          }
          rows + player.piece_box.detail_score
        end
      end
    end
  end
end
