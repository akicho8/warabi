# -*- coding: utf-8 -*-
#
# 一次元座標管理
#
module Bushido
  module Position
    class Base
      attr_reader :value
      private_class_method :new

      # 座標をパースする
      #   Position::Hpos.parse("１").name # => "1"
      def self.parse(arg)
        case arg
        when String, NilClass
          v = units.find_index{|e|e == arg}
          v or raise PositionSyntaxError, "#{arg.inspect} が #{units} の中にありません"
        when Base
          v = arg.value
        else
          v = arg
        end
        new(v)
      end

      # 幅
      def self.value_range
        (0 .. units.size - 1)
      end

      def initialize(value)
        @value = value
      end

      # 座標が盤上か？
      def valid?
        self.class.value_range.include?(@value)
      end

      # 名前
      #   Position::Vpos.parse("一").name # => "一"
      def name
        self.class.units[@value]
      end

      # 数字表記
      #   Position::Vpos.parse("一").number_format # => "1"
      def number_format
        name
      end

      # 座標反転
      #   Position::Hpos.parse("1").reverse.name # => "9"
      def reverse
        self.class.parse(self.class.units.size - 1 - @value)
      end

      # インスタンスが異なっても同じ座標なら同じ
      def ==(other)
        self.class == other.class && @value == other.value
      end

      def inspect
        "#<#{self.class.name}:#{object_id} #{name.inspect} #{@value}>"
      end
    end

    class Hpos < Base
      def self.units
        "987654321".chars.to_a
      end

      def self.zenkaku_units
        "９８７６５４３２１".chars.to_a
      end

      # "５五" の全角 "５" に対応するため
      def self.parse(arg)
        if arg.kind_of?(String) && arg.match(/[１-９]/)
          arg = arg.tr("１-９", units.reverse.join)
        end
        super
      end
    end

    class Vpos < Base
      def self.units
        "一二三四五六七八九".chars.to_a
      end

      def self.zenkaku_units
        units
      end

      # "(52)" の "2" に対応するため
      def self.parse(arg)
        if arg.kind_of?(String) && arg.match(/\d/)
          arg = arg.tr("1-9", units.join)
        end
        super
      end

      def number_format
        super.tr(self.class.units.join, "1-9")
      end
    end
  end
end
