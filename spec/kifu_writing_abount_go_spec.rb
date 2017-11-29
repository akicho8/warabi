require_relative "spec_helper"

module Bushido
  describe "古い棋譜にある「行」について" do
    def test1(str)
      mediator = Bushido::Mediator.new
      mediator.board_reset_for_text(<<~EOT)
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・v角|
| ・ ・ ・ ・ ・ ・ ・ ・ ・|
| ・ ・ ・ ・ ・ ・ ・ ・ ・|
| ・ ・ ・ ・ ・ ・ ・ ・ ・|
| ・ ・ ・ ・v角 ・ ・ ・v飛|
| ・ ・ ・ ・ ・ ・ ・ ・ ・|
|v金 ・ ・ ・ ・ ・ ・ ・ ・|
|v金 ・v金 ・ ・ ・ ・ ・ ・|
| ・ ・ ・ ・ ・ ・ ・ ・v飛|
+---------------------------+
        EOT
      mediator.next_player.execute(str)
      mediator.hand_logs.last.to_kif_ki2_csa
    end

    it "エラー" do
      expect { test1("１七飛成") }.to raise_error(AmbiguousFormatError, /移動できる駒が多すぎます/)
      expect { test1("３三角") }.to raise_error(AmbiguousFormatError, /移動できる駒が多すぎます/)
    end

    it "「上」は「行」と書ける" do
      test1("１七飛上").should == ["１七飛(15)", "１七飛上不成", "-1517HI"]
      test1("１七飛行").should == ["１七飛(15)", "１七飛上不成", "-1517HI"]

      test1("３三角上").should == ["３三角(11)", "３三角上", "-1133KA"]
      test1("３三角行").should == ["３三角(11)", "３三角上", "-1133KA"]
    end

    it "ただし大駒以外には使えない" do
      test1("８八金右上").should == ["８八金(97)", "８八金右上", "-9788KI"]
      expect { test1("８八金右行") }.to raise_error(AmbiguousFormatError, /移動できる駒が多すぎます/)
    end
  end
end