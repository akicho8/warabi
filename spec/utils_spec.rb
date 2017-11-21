require_relative "spec_helper"

module Bushido
  describe Utils do
    it "初期配置情報の塊を分離" do
      Utils.initial_soldiers_split("▲４二銀 △４二銀").should == [{location: Location[:black], input: "４二銀"}, {location: Location[:white], input: "４二銀"}]
    end

    it "座標と駒の分解" do
      MiniSoldier.from_str("４二銀").should == {point: Point["４二"], piece: Piece["銀"], promoted: false}
      MiniSoldier.from_str("４二竜").should == {point: Point["４二"], piece: Piece["飛"], promoted: true}
    end

    it "棋譜入力の分離(ゴミは保持)" do
      Utils.ki2_parse("▲５五歩△４四歩 push ▲３三歩 pop").should == [{location: Location[:black], input: "５五歩"}, {location: Location[:white], input: "４四歩"}, "push", {location: Location[:black], input: "３三歩"}, "pop"]
    end

    it "棋譜入力の分離(一つだけ)" do
      Utils.mov_split_one("▲５五歩").should == {location: Location[:black], input: "５五歩"}
    end

    describe "movs_split" do
      it "棋譜入力の分離(ゴミがあっても無視)" do
        Utils.movs_split("▲５五歩△４四歩 push ▲３三歩 pop").should == [{location: Location[:black], input: "５五歩"}, {location: Location[:white], input: "４四歩"}, {location: Location[:black], input: "３三歩"}]
      end
      it "先手後手がわからないと無視する" do
        Utils.movs_split("５五歩").should == []
      end
    end

    describe "持駒表記変換" do
      before do
        @pieces = [Piece["歩"], Piece["歩"], Piece["飛"]]
      end

      describe "プレイヤーのスコープ" do
        it "人間表記 → コード" do
          Utils.hold_pieces_s_to_a("歩2 飛").should           == @pieces
          Utils.hold_pieces_s_to_a("歩歩 飛").should          == @pieces
          Utils.hold_pieces_s_to_a("歩2 飛1").should          == @pieces
          Utils.hold_pieces_s_to_a("歩2 飛 角0").should       == @pieces
          Utils.hold_pieces_s_to_a("歩二 飛").should          == @pieces
          Utils.hold_pieces_s_to_a("歩二飛角〇").should       == @pieces
          Utils.hold_pieces_s_to_a("　歩二　\n　飛　").should == @pieces
          Utils.hold_pieces_s_to_a(" 歩二 飛 ").should        == @pieces
          Utils.hold_pieces_s_to_a(" 歩 二飛 ").should_not    == @pieces
        end

        it "コード → 人間表記" do
          Utils.hold_pieces_a_to_s(@pieces).should                == "歩二 飛"
          Utils.hold_pieces_a_to_s(@pieces, ordered: true).should == "飛 歩二"
          Utils.hold_pieces_a_to_s(@pieces, separator: "").should == "歩二飛"
        end
      end

      describe "全体スコープ" do
        before { @hash = {Location[:black] => "歩2 飛 金", Location[:white] => "歩二飛 "} }
        it "人間表記 → コード" do
          Utils.triangle_hold_pieces_str_to_hash("▲歩2 飛 △歩二飛 ▲金").should == @hash
        end
        it "コード → 表記" do
          Utils.triangle_hold_pieces_hash_to_str(@hash).should == "▲歩2 飛 金 △歩二飛 "
        end
      end
    end

    describe "初期配置" do
      before do
        @white_king = [MiniSoldier[piece: Piece["玉"], promoted: false, point: Point["５一"], location: Location[:white]]]
        @black_king = [MiniSoldier[piece: Piece["玉"], promoted: false, point: Point["５九"], location: Location[:black]]]
        @black_rook = [MiniSoldier[piece: Piece["飛"], promoted: false, point: Point["１一"], location: Location[:black]]]
      end

      it "先手か後手の一方用" do
        Utils.location_mini_soldiers(location: Location[:white], key: "十九枚落ち").should == @white_king
        Utils.location_mini_soldiers(location: Location[:black], key: "十九枚落ち").should == @black_king
      end

      describe "board_reset の3通りの引数を先手・後手をキーしたハッシュにする" do
        it "先手→十九枚落ち 後手→平手" do
          r = Utils.board_reset_args("十九枚落ち")
          r[Location[:black]].should == @black_king
          r[Location[:white]].should be_a Array # 平手
        end

        it "先手→十九枚落ち 後手→十九枚落ち(DSL用)" do
          r = Utils.board_reset_args("先手" => "十九枚落ち", "後手" => "十九枚落ち")
          r[Location[:black]].should == @black_king
          r[Location[:white]].should == @white_king
        end

        it "盤面指定" do
          r = Utils.board_reset_args(<<~EOT)
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・ ・ ・v玉 ・ ・ ・ ・|一
| ・ ・ ・ ・ ・ ・ ・ ・ ・|二
| ・ ・ ・ ・ ・ ・ ・ ・ ・|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ ・ ・ 玉 ・ ・ ・ ・|九
+---------------------------+
EOT
          r[Location[:black]].should == @black_king
          r[Location[:white]].should == @white_king
        end
      end
    end
  end
end
