# -*- coding: utf-8 -*-

require "spec_helper"

module Bushido
  describe Piece do
    it "コレクション" do
      Piece.each.should be_present
    end

    it "取得" do
      Piece[:pawn].class.should == Piece::Pawn
      Piece.get(:pawn).class.should == Piece::Pawn
      Piece.get("歩").class.should == Piece::Pawn
      Piece.get("").should == nil
      Piece.get(nil).should == nil
    end

    it "get!の場合、無効な名前だったら例外を出す" do
      expect { Piece.get!("成龍") }.to raise_error(PieceNotFound)
      expect { Piece.get!("成と") }.to raise_error(PieceNotFound)
      expect { Piece.get!("成飛") }.to raise_error(PieceNotFound)
    end

    it "駒の情報" do
      piece = Piece.get("飛")
      piece.name.should              == "飛"
      piece.promoted_name.should     == "龍"
      piece.basic_names.should       == ["飛", "rook"]
      piece.promoted_names.should    == ["龍", "ROOK", "竜"]
      piece.names.should             == ["飛", "rook", "龍", "ROOK", "竜"]
      piece.sym_name.should          == :rook
      piece.promotable?.should       == true
      piece.basic_step_vectors.should    == []
      piece.basic_series_vectors.should    == [nil, [0, -1], nil, [-1, 0], [1, 0], nil, [0, 1], nil]
      piece.promoted_step_vectors.should == [[-1, -1], [0, -1], [1, -1], [-1, 0], nil, [1, 0], [-1, 1], [0, 1], [1, 1]]
      piece.promoted_series_vectors.should == [nil, [0, -1], nil, [-1, 0], [1, 0], nil, [0, 1], nil]
    end

    it "同じ種類の駒ならオブジェクトは同じだけどcloneすると変わる" do
      (Piece.get("歩") == Piece.get("歩")).should == true
      (Piece.get("歩").clone == Piece.get("歩")).should == false
    end

    # it "シリアライズ" do
    #   p Piece.get("歩")
    #   s = Marshal.load(Marshal.dump(Piece.instance))
    #   p s
    #   p Piece.get("歩")
    # end
  end
end

