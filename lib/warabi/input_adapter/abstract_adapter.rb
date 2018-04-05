# frozen-string-literal: true
#
# >> |------------+----------+-------+------+-------+-------------+--------------+------------+----------+----------+--------+----------------+-------------------+------------------+------------+--------+----------+---------------------|
# >> | source     | triangle | absolute_place | same | piece | ki2_motion_part | kif_trigger_part | place_from | csa_sign | csa_from | csa_to | csa.basic_name | csa.promoted_name | usi_drop_piece | usi_drop_trigger | usi_to | usi_from | usi_promote_trigger |
# >> |------------+----------+-------+------+-------+-------------+--------------+------------+----------+----------+--------+----------------+-------------------+------------------+------------+--------+----------+---------------------|
# >> | ６八銀左   |          | ６八  |      | 銀    | 左          |              |            |          |          |        |                |                   |                  |            |        |          |                     |
# >> | △６八全   | △       | ６八  |      | 全    |             |              |            |          |          |        |                |                   |                  |            |        |          |                     |
# >> | △６八銀成 | △       | ６八  |      | 銀    |             | 成           |            |          |          |        |                |                   |                  |            |        |          |                     |
# >> | △６八銀打 | △       | ６八  |      | 銀    |             | 打           |            |          |          |        |                |                   |                  |            |        |          |                     |
# >> | △同銀     | △       |       | 同   | 銀    |             |              |            |          |          |        |                |                   |                  |            |        |          |                     |
# >> | △同銀成   | △       |       | 同   | 銀    |             | 成           |            |          |          |        |                |                   |                  |            |        |          |                     |
# >> | ７六歩(77) |          | ７六  |      | 歩    |             |              | (77)       |          |          |        |                |                   |                  |            |        |          |                     |
# >> | 7677FU     |          |       |      |       |             |              |            |          |       76 |     77 | FU             |                   |                  |            |        |          |                     |
# >> | -7677FU    |          |       |      |       |             |              |            | -        |       76 |     77 | FU             |                   |                  |            |        |          |                     |
# >> | +0077RY    |          |       |      |       |             |              |            | +        |       00 |     77 |                | RY                |                  |            |        |          |                     |
# >> | 8c8d       |          |       |      |       |             |              |            |          |          |        |                |                   |                  |            | 8d     | 8c       |                     |
# >> | P*2f       |          |       |      |       |             |              |            |          |          |        |                |                   | P                | *          | 2f     |          |                     |
# >> | 4e5c+      |          |       |      |       |             |              |            |          |          |        |                |                   |                  |            | 5c     | 4e       | +                   |
# >> |------------+----------+-------+------+-------+-------------+--------------+------------+----------+----------+--------+----------------+-------------------+------------------+------------+--------+----------+---------------------|

module Warabi
  module InputAdapter
    class AbstractAdapter
      attr_reader :player
      attr_reader :input

      delegate :board, to: :player

      def initialize(player, input)
        @player = player
        @input = input
      end

      def perform_validations
        hard_validations
        if errors.empty?
          soft_validations
        end
      end

      def errors
        @errors ||= []
      end

      def errors_add(error_class, message)
        errors << {error_class: error_class, message: message}
      end

      # 目的地に来れる盤上の駒の配列
      def candidate_soldiers
        @candidate_soldiers ||= player.candidate_soldiers(piece: piece, promoted: !promote_trigger && promoted, place: place)
      end

      def candidate_soldiers_as_string
        candidate_soldiers.collect(&:name).join(', ')
      end

      def soldier
        @soldier ||= Soldier.create(piece: piece, promoted: promoted, place: place, location: player.location)
      end

      def move_hand
        if origin_soldier
          @move_hand ||= MoveHand.create(soldier: soldier, origin_soldier: origin_soldier, captured_soldier: board.surface[place])
        end
      end

      def drop_hand
        unless origin_soldier
          @drop_hand ||= DropHand.create(soldier: soldier)
        end
      end

      def hand
        @hand ||= move_hand || drop_hand
      end

      def to_h
        {
          :place_from      => place_from,
          :place           => place,
          :piece           => piece,
          :promoted        => promoted,
          :promote_trigger => promote_trigger,
          :drop_trigger    => drop_trigger,
          :errors          => errors,
        }
      end

      private

      def hard_validations
      end

      def soft_validations
      end
    end
  end
end
