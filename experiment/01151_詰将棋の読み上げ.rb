require "./example_helper"

info = Parser.parse("position sfen 4k4/9/4G4/9/9/9/9/9/9 b 2G2r2b2g4s4n4l18p 1")
info.to_yomiage # => "gyokugata。ごーいちgyoku。せめかた。ごーさんkin。もちごま。kin。kin。"


info = Bioshogi::Parser.parse("position sfen 7g1/8k/7pB/9/9/9/9/9/8L b k2rb3g4s4n3l17p 1")
info.to_yomiage                 # => "gyokugata。いちにぃgyoku。にぃいちkin。にぃさんhu。せめかた。いちさんkaku。いちきゅうkyo。もちごま。なし。"
