# frozen-string-literal: true

module Warabi
  # P1-KY-KE-GI-KI-OU-KI-GI-KE-KY
  # P2 * -HI *  *  *  *  * -KA *
  # P3-FU-FU-FU-FU-FU-FU-FU-FU-FU
  # P4 *  *  *  *  *  *  *  *  *
  # P5 *  *  *  *  *  *  *  *  *
  # P6 *  *  *  *  *  *  *  *  *
  # P7+FU+FU+FU+FU+FU+FU+FU+FU+FU
  # P8 * +KA *  *  *  *  * +HI *
  # P9+KY+KE+GI+KI+OU+KI+GI+KE+KY
  class CsaBoardFormater
    def initialize(board)
      @board = board
    end

    def to_s
      Position::Vpos.dimension.times.collect { |y|
        "P#{y.next}" + Position::Hpos.dimension.times.collect { |x|
          point = Point.fetch([x, y])
          battler_to_str(@board[point])
        }.join + "\n"
      }.join
    end

    private

    def battler_to_str(battler)
      if battler
        battler.to_csa
      else
        " * "
      end
    end
  end
end
