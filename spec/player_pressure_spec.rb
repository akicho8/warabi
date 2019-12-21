require_relative "spec_helper"

module Bioshogi
  describe Player do
    it "終盤度" do
      mediator = Mediator.new
      mediator.placement_from_bod(<<~EOT)
      後手の持駒：桂
      +---------+
      | ・ ・v玉|
      | ・ ・ ・|
      | ・ 金 ・|
      +---------+
      先手の持駒：香2
      EOT
      player = mediator.player_at(:black)
      assert { player.soldiers_pressure_level  == 3       }
      assert { player.piece_box.pressure_level == 2       }
      assert { player.pressure_level           ==  5      }
      assert { player.pressure_rate            ==  0.3125 }

      player = mediator.player_at(:white)
      assert { player.soldiers_pressure_level  ==  0      }
      assert { player.piece_box.pressure_level ==  1      }
      assert { player.pressure_level           ==  1      }
      assert { player.pressure_rate            ==  0.0625 }
    end
  end
end
