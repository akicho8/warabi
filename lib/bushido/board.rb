# -*- coding: utf-8 -*-
#
# 盤面
#   board = Board.new
#   board["５五"] # => nil
#
module Bushido
  class Board
    attr_reader :surface

    # 一時的に盤面のサイズを変更する(テスト用)
    #
    #   before do
    #     @size_save = Board.size_change([3, 5])
    #   end
    #   after do
    #     Board.size_change(@size_save)
    #   end
    #
    def self.size_change(size, &block)
      size_save = [Position::Hpos.ridge_length, Position::Vpos.ridge_length]
      # p "#{size_save}を保存"
      Position::Hpos.ridge_length, Position::Vpos.ridge_length = size
      # p "#{size}に設定"
      if block_given?
        begin
          yield
        ensure
          Position::Hpos.ridge_length, Position::Vpos.ridge_length = size_save
          # p "#{size_save}に戻した"
        end
      end
      size_save
    end

    def initialize
      @surface = {}
    end

    # 縦列の盤上のすべての駒
    def pieces_of_vline(x)
      Position::Vpos.ridge_length.times.collect{|y|
        fetch(Point.parse([x, y]))
      }.compact
    end

    # 指定座標に駒を置く
    #   board.put_on_at("５五", soldier)
    def put_on_at(point, soldier)
      assert_board_cell_is_blank(point)
      # assert_not_double_pawn(player, point, piece)

      soldier.point = point
      # soldier.double_pawn_validation(self, point)

      @surface[point.to_xy] = soldier
    end

    # fetchのエイリアス
    #   board["５五"] # => nil
    def [](point)
      fetch(point)
    end

    # 盤面の指定座標の取得
    #   board.fetch["５五"] # => nil
    def fetch(point)
      @surface[Point.parse(point).to_xy]
    end

    # 指定座標にある駒をを広い上げる
    def pick_up!(point)
      soldier = @surface.delete(point.to_xy)
      soldier or raise NotFoundOnBoard, "#{point.name}の位置には何もありません"
      soldier.point = nil
      soldier
    end

    # 盤面表示
    #   to_s
    #   to_s(:debug)
    #   to_s(:kakiki)
    def to_s(format = :default)
      send("to_s_#{format}")
    end

    # 空いている場所のリスト
    def blank_points
      Point.all_points.find_all{|point|!fetch(point)}
    end

    # 置いてる駒リスト
    def to_s_soldiers
      @surface.values.collect(&:formality_name2).sort.join(" ")
    end

    private

    # 盤面の文字列化
    def to_s_default
      to_s(:kakiki)
    end

    # 盤面の文字列化(開発用なので好きなフォーマットでいい)
    def to_s_debug
      rows = Position::Vpos.ridge_length.times.collect{|y|
        Position::Hpos.ridge_length.times.collect{|x|
          @surface[[x, y]]
        }
      }
      rows = rows.zip(Position::Vpos.units).collect{|e, u|e + [u]}
      RainTable::TableFormatter.format(Position::Hpos.units + [""], rows, :header => true)
    end

    # 盤上の指定座標にすでに物があるならエラーとする
    def assert_board_cell_is_blank(point)
      if fetch(point)
        raise PieceAlredyExist, "#{point.name}にはすでに何かがあります"
      end
    end
  end
end
