require_relative "spec_helper"

module Bioshogi
  describe do
    it "works" do
      info = Parser.parse("position sfen 4k4/9/4G4/9/9/9/9/9/9 b 2G2r2b2g4s4n4l18p 1")
      assert { info.to_yomiage == "gyokugata。ごーいちgyoku。せめかた。ごーさんkin。もちごま。kin。kin。" }
      info = Bioshogi::Parser.parse("position sfen 7g1/8k/7pB/9/9/9/9/9/8L b k2rb3g4s4n3l17p 1")
      assert { info.to_yomiage == "gyokugata。いちにぃgyoku。にぃいちkin。にぃさんhu。せめかた。いちさんkaku。いちきゅうkyo。もちごま。なし。" }
      info = Bioshogi::Parser.parse("position sfen 7gk/7ns/4G4/9/9/9/9/9/9 b 2r2b2g3s3n4l18p 1")
      assert { info.to_yomiage == "gyokugata。いちいちgyoku。いちにぃ銀。にぃいちkin。にぃにぃkeima。せめかた。ごーさんkin。もちごま。なし。" }
    end
  end
end
