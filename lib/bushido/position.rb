# -*- coding: utf-8 -*-
#
# 一次元座標管理
#
module Bushido
  module Position
    class Base
      attr_accessor :value

      private_class_method :new

      # 座標をパースする
      #   Position::Hpos.parse("１").name # => "1"
      def self.parse(arg)
        case arg
        when String
          v = units.find_index{|e|e == arg}
          v or raise UnknownPositionName, "#{arg.inspect} が #{units} の中にありません"
        when Base
          v = arg.value
        else
          v = arg
        end
        new(v)
      end

      def self.value_range
        (0 .. units.size - 1)
      end

      def valid?
        self.class.value_range.include?(@value)
      end

      def initialize(value)
        @value = value
      end

      def name
        self.class.units[@value]
      end

      def reverse
        self.class.parse(self.class.units.size - 1 - @value)
      end

      def inspect
        "#<#{self.class.name}:#{object_id} #{name.inspect} #{@value}>"
      end

      def ==(other)
        self.class == other.class && @value == other.value
      end
    end

    class Hpos < Base
      def self.units
        "987654321".scan(/./)
      end

      def self.zenkaku_units
        "９８７６５４３２１".scan(/./)
      end

      # "５五" の全角 "５" に対応するため
      def self.parse(arg)
        if arg.kind_of?(String) && arg.match(/[１-９]/)
          arg = arg.tr("１-９", units.reverse.join)
        end
        super
      end

      def number_format
        name
      end
    end

    class Vpos < Base
      def self.units
        "一二三四五六七八九".scan(/./)
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
        name.tr(self.class.units.join, "1-9")
      end
    end
  end
end
