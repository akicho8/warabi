# frozen-string-literal: true
#
# 座標
#
#   Place["４三"].name   # => "４三"
#   Place["４三"].name  # => "４三"
#   Place["43"].name    # => "４三"
#
module Warabi
  class Place
    attr_accessor :x, :y

    class << self
      private :new

      include Enumerable

      def each(&block)
        Dimension::Xplace.dimension.times.flat_map { |y|
          Dimension::Yplace.dimension.times.collect { |x|
            self[[x, y]]
          }
        }.each(&block)
      end

      def fetch(value)
        lookup(value) or raise SyntaxDefact, "座標が読み取れません : #{value.inspect}"
      end

      def lookup(value)
        if value.kind_of?(self)
          return value
        end

        x = nil
        y = nil

        case value
        when Array
          a, b = value
          x = Dimension::Yplace.lookup(a)
          y = Dimension::Xplace.lookup(b)
        when String
          a, b = value.chars
          x = Dimension::Yplace.lookup(a)
          y = Dimension::Xplace.lookup(b)
        end

        if x && y
          @memo ||= {}
          @memo[x] ||= {}
          @memo[x][y] ||= new(x, y).freeze
        end
      end

      def [](value)
        lookup(value)
      end

      def regexp
        /[一二三四五六七八九１-９1-9]{2}/
      end
    end

    def initialize(x, y)
      @x = x
      @y = y
    end

    def inspect
      "#<#{self.class.name} #{name}>"
    end

    def to_xy
      [@x.value, @y.value]
    end

    def flip
      self.class.fetch([@x.flip, @y.flip])
    end

    def flip_if_white(location)
      if Location[location].key == :white
        flip
      else
        self
      end
    end

    def name
      if valid?
        to_a.collect(&:name).join
      else
        "盤外"
      end
    end

    def to_s
      name
    end

    def number_format
      to_a.collect(&:number_format).join
    end

    def to_sfen
      to_a.collect(&:to_sfen).join
    end

    def to_a
      [@x, @y]
    end

    def vector_add(vector)
      x, y = vector
      self.class.fetch([@x.value + x, @y.value + y])
    end

    def valid?
      @x.valid? && @y.valid?
    end

    def invalid?
      !valid?
    end

    def ==(other)
      eql?(other)
    end

    def <=>(other)
      to_xy <=> other.to_xy
    end

    def eql?(other)
      self.class == other.class && to_xy == other.to_xy
    end

    def hash
      to_xy.hash
    end

    def promotable?(location)
      @y.promotable?(location)
    end
  end
end
