# -*- coding: utf-8 -*-

require "spec_helper"

module Bushido
  describe MiniSoldier do
    it ".from_str" do
      MiniSoldier.from_str("５一玉").to_s.should == "5一玉"
    end

    it "#to_s" do
      MiniSoldier[point: Point["５一"], piece: Piece["玉"]].to_s.should == "5一玉"
    end
  end

  describe SoldierMove do
    it "#to_hand" do
      SoldierMove[point: Point["１三"], piece: Piece["銀"], origin_soldier: MiniSoldier.from_str("１四銀"), promoted_trigger: true].to_hand.should == "1三銀成(14)"
    end
  end

  # describe PieceStake do
  # end
end
