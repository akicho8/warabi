require "./example_helper"

InputParser.scan("▲４二銀 △４二銀")                  # => ["▲４二銀", "△４二銀"]
InputParser.scan("▲５五歩△４四歩 push ▲３三歩 pop") # => ["▲５五歩", "△４四歩", "▲３三歩"]
InputParser.scan("５五歩")                             # => ["５五歩"]
InputParser.slice_one("▲５五歩△６八銀")              # => "▲５五歩"

list = [
  "６八銀左上",
  "△６八全",
  "△６八銀成",
  "△６八銀打",
  "△同銀",
  "△同銀成",
  "７六歩(77)",
  "7677FU",
  "-7677FU",
  "+0077RY",
  "8c8d",
  "P*2f",
  "4e5c+",
]
tp list.collect { |e| {source: e}.merge(InputParser.match!(e).named_captures) }
InputParser.scan(list.join) == list # => true
InputParser.scan(list.join) # => ["６八銀左上", "△６八全", "△６八銀成", "△６八銀打", "△同銀", "△同銀成", "７六歩(77)", "7677FU", "-7677FU", "+0077RY", "8c8d", "P*2f", "4e5c+"]

InputParser.match!("△６八銀打").named_captures # => {"ki2_location"=>"△", "kif_place"=>"６八", "ki2_same"=>nil, "kif_piece"=>"銀", "ki2_one_up"=>nil, "ki2_left_right"=>nil, "ki2_up_down"=>nil, "ki2_as_it_is"=>nil, "ki2_promote_trigger"=>nil, "kif_drop_trigger"=>"打", "kif_place_from"=>nil, "csa_sign"=>nil, "csa_from"=>nil, "csa_to"=>nil, "csa_piece"=>nil, "sfen_drop_piece"=>nil, "sfen_drop_trigger"=>nil, "sfen_to"=>nil, "sfen_from"=>nil, "sfen_promote_trigger"=>nil}

# >> |------------+--------------+-----------+----------+-----------+------------+----------------+-------------+--------------+---------------------+------------------+----------------+----------+----------+--------+-----------+----------------+------------------+--------+----------+---------------------|
# >> | source     | ki2_location | kif_place | ki2_same | kif_piece | ki2_one_up | ki2_left_right | ki2_up_down | ki2_as_it_is | ki2_promote_trigger | kif_drop_trigger | kif_place_from | csa_sign | csa_from | csa_to | csa_piece | sfen_drop_piece | sfen_drop_trigger | sfen_to | sfen_from | sfen_promote_trigger |
# >> |------------+--------------+-----------+----------+-----------+------------+----------------+-------------+--------------+---------------------+------------------+----------------+----------+----------+--------+-----------+----------------+------------------+--------+----------+---------------------|
# >> | ６八銀左上 |              | ６八      |          | 銀        |            | 左             | 上          |              |                     |                  |                |          |          |        |           |                |                  |        |          |                     |
# >> | △６八全   | △           | ６八      |          | 全        |            |                |             |              |                     |                  |                |          |          |        |           |                |                  |        |          |                     |
# >> | △６八銀成 | △           | ６八      |          | 銀        |            |                |             |              | 成                  |                  |                |          |          |        |           |                |                  |        |          |                     |
# >> | △６八銀打 | △           | ６八      |          | 銀        |            |                |             |              |                     | 打               |                |          |          |        |           |                |                  |        |          |                     |
# >> | △同銀     | △           |           | 同       | 銀        |            |                |             |              |                     |                  |                |          |          |        |           |                |                  |        |          |                     |
# >> | △同銀成   | △           |           | 同       | 銀        |            |                |             |              | 成                  |                  |                |          |          |        |           |                |                  |        |          |                     |
# >> | ７六歩(77) |              | ７六      |          | 歩        |            |                |             |              |                     |                  | (77)           |          |          |        |           |                |                  |        |          |                     |
# >> | 7677FU     |              |           |          |           |            |                |             |              |                     |                  |                |          |       76 |     77 | FU        |                |                  |        |          |                     |
# >> | -7677FU    |              |           |          |           |            |                |             |              |                     |                  |                | -        |       76 |     77 | FU        |                |                  |        |          |                     |
# >> | +0077RY    |              |           |          |           |            |                |             |              |                     |                  |                | +        |       00 |     77 | RY        |                |                  |        |          |                     |
# >> | 8c8d       |              |           |          |           |            |                |             |              |                     |                  |                |          |          |        |           |                |                  | 8d     | 8c       |                     |
# >> | P*2f       |              |           |          |           |            |                |             |              |                     |                  |                |          |          |        |           | P              | *                | 2f     |          |                     |
# >> | 4e5c+      |              |           |          |           |            |                |             |              |                     |                  |                |          |          |        |           |                |                  | 5c     | 4e       | +                   |
# >> |------------+--------------+-----------+----------+-----------+------------+----------------+-------------+--------------+---------------------+------------------+----------------+----------+----------+--------+-----------+----------------+------------------+--------+----------+---------------------|
