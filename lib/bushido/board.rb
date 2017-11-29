# frozen-string-literal: true
#
# 盤面
#   board = Board.new
#   board["５五"] # => nil
#
module Bushido
  class Board
    attr_reader :surface

    class << self
      delegate :size_change, :size_type, :disable_promotable, :to => "Bushido::Position"
    end

    def initialize
      @surface = {}
    end

    # 破壊的
    concerning :UpdateMethods do
      # 指定座標に駒を置く
      #   board.put_on("５五", soldier)
      def put_on(point, soldier)
        assert_board_cell_is_blank(point)
        raise MustNotHappen if soldier.point != point
        # soldier.point = point
        # set(point, soldier)
        @surface[Point[point].to_xy] = soldier # TODO: Point オブジェクトのままセットすることはできないか？
      end

      # 指定座標にある駒をを広い上げる
      def pick_up!(point)
        soldier = @surface.delete(point.to_xy)
        unless soldier
          raise NotFoundOnBoard, "#{point.name.inspect} の位置には何もありません"
        end
        soldier.point = nil
        soldier
      end

      # 駒をすべて削除する
      def abone_all
        @surface.values.find_all { |e| e.kind_of?(Soldier) }.each(&:abone)
      end

      # 指定のセルを削除する
      # プレイヤー側の soldiers からは削除しないので注意
      def abone_on(point)
        @surface.delete(point.to_xy)
      end
    end

    concerning :ReaderMethods do
      # 盤面の指定座標の取得
      #   board.lookup["５五"] # => nil
      def lookup(point)
        @surface[Point[point].to_xy] # FIXME: to_xy をリアルな配列ではなくシンボルになるようにすれば速度改善できるか……？
      end

      # lookupのエイリアス
      #   board["５五"] # => nil
      def [](point)
        lookup(point)
      end

      # 空いている場所のリスト
      def blank_points
        Point.find_all { |point| !lookup(point) }
      end

      # X列の駒たち
      def vertical_pieces(x)
        Position::Vpos.board_size.times.collect { |y|
          lookup(Point[[x, y]])
        }.compact
      end

      def to_s_soldiers
        @surface.values.collect(&:formal_name).sort.join(" ")
      end

      def to_s_soldiers2
        @surface.values.collect(&:mark_with_formal_name).sort.join(" ")
      end

      def to_s_kakiki
        KakikiFormat.new(self).to_s
      end

      def to_csa
        CsaBoardFormat.new(self).to_s
      end

      def to_s
        to_s_kakiki
      end
    end

    private

    # 盤上の指定座標に駒があるならエラーとする
    def assert_board_cell_is_blank(point)
      soldier = lookup(point)
      if soldier
        raise PieceAlredyExist, "#{point.name}にはすでに#{soldier}があります\n#{self}"
      end
    end

    concerning :TeaiwariMethods do
      # ▲が平手であることが条件
      def teaiwari_name
        if teaiwari_name_by_location(:black) == "平手"
          teaiwari_name_by_location(:white)
        end
      end

      private

      # location 側の手合割を文字列で得る
      def teaiwari_name_by_location(location)
        teaiwari_info_by_location(location)&.name
      end

      # location 側の手合割情報を得る
      def teaiwari_info_by_location(location)
        location = Location[location]

        # 手合割情報はすべて先手のデータなので、先手側から見た状態に揃える
        sorted_black_side_mini_soldiers = @surface.values.collect { |e|
          if e.location == location
            e.to_mini_soldier.as_black_side
          end
        }.compact.sort

        TeaiwariInfo.find do |e|
          e.sorted_black_side_mini_soldiers == sorted_black_side_mini_soldiers
        end
      end
    end
  end
end
