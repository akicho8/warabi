# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/piece_spec.rb" -*-
#
# 駒
#   Piece["歩"].name  # => "歩"
#   Piece[:pawn].name # => "歩"
#   Piece.each{|piece|...}
#

require "singleton"

module Bushido
  class Piece
    include Singleton

    class << self
      include Enumerable

      private :instance

      def each(&block)
        instance.pool.each(&block)
      end

      # get(arg) の alias
      def [](arg)
        get(arg)
      end

      # 駒オブジェクトを得る
      #   Piece.get(nil)       # => nil
      #   Piece.get("歩").name # => "歩"
      #   Piece.get("と").name # => "歩"
      #   「と」も「歩」も区別しない。区別したい場合は parse! を使うこと
      #   エラーにしたいときは get! を使う
      def get(arg)
        basic_get(arg) || promoted_get(arg)
      end

      # Piece.get!("歩").name # => "歩"
      def get!(arg)
        get(arg) or raise PieceNotFound, "#{arg.inspect} に対応する駒がありません"
      end

      # Piece.get!("歩").name # => "歩"
      def parse!(arg)
        case
        when piece = basic_get(arg)
          {:piece => piece, :promoted => false}
        when piece = promoted_get(arg)
          {:piece => piece, :promoted => true}
        else
          raise PieceNotFound, "#{arg.inspect} に対応する駒がありません"
        end
      end

      def names
        collect(&:names).flatten
      end

      private

      def basic_get(arg)
        find{|piece|piece.basic_names.include?(arg.to_s)}
      end

      def promoted_get(arg)
        find{|piece|piece.promoted_names.include?(arg.to_s)}
      end
    end

    attr_reader :pool

    def initialize
      @pool = [:pawn, :bishop, :rook, :lance, :knight, :silver, :gold, :king].collect{|key|
        "Bushido::Piece::#{key.to_s.classify}".constantize.new
      }
    end

    # 駒共通クラス
    #
    # ここで == を定義すると面倒なことになるので注意。
    # 持駒の歩を取り出すため `player.pieces.delete(Piece["歩"])' としたとき歩が全部消えてしまう。
    # 同じ種類の駒、同じ種類の別の駒を分けて判別するためには == を定義しない方がいい。
    class Base
      module NameMethods
        def some_name(promoted)
          if promoted
            promoted_name
          else
            name
          end
        end

        def name
          raise NotImplementedError, "#{__method__} is not implemented"
        end

        def sym_name
          self.class.name.demodulize.underscore.to_sym
        end

        def promoted_name
        end

        def names
          basic_names + promoted_names
        end

        def basic_names
          [name, sym_name.to_s]
        end

        def promoted_names
          [promoted_name, sym_name.to_s.upcase].compact
        end
      end

      include NameMethods

      module VectorMethods
        def basic_vectors1
          []
        end

        def basic_vectors2
          []
        end

        def promoted_vectors1
          []
        end

        def promoted_vectors2
          []
        end

        def vectors1(promoted = false)
          assert_promotable(promoted)
          promoted ? promoted_vectors1 : basic_vectors1
        end

        def vectors2(promoted = false)
          assert_promotable(promoted)
          promoted ? promoted_vectors2 : basic_vectors2
        end
      end

      include VectorMethods

      def promotable?
        true
      end

      def assert_promotable(promoted)
        if !promotable? && promoted
          raise NotPromotable
        end
      end

      def inspect
        "<#{self.class.name}:#{object_id} #{name} #{sym_name}>"
      end
    end

    module Goldable
      def promoted_vectors1
        Gold.basic_pattern
      end
    end

    module Brave
      def promoted_vectors1
        King.basic_pattern
      end

      def promoted_vectors2
        basic_vectors2
      end
    end

    class Pawn < Base
      include Goldable

      def name
        "歩"
      end

      def promoted_name
        "と"
      end

      def basic_vectors1
        [[0, -1]]
      end
    end

    class Bishop < Base
      include Brave

      def name
        "角"
      end

      def promoted_name
        "馬"
      end

      def basic_vectors2
        [
          [-1, -1], nil, [1, -1],
          nil,      nil,     nil,
          [-1,  1], nil, [1,  1],
        ]
      end
    end

    class Rook < Base
      include Brave

      def name
        "飛"
      end

      def promoted_name
        "龍"
      end

      def promoted_names
        super + ["竜"]
      end

      def basic_vectors2
        [
          nil,      [0, -1],     nil,
          [-1,  0],          [1,  0],
          nil,      [0,  1],     nil,
        ]
      end
    end

    class Lance < Base
      include Goldable

      def name
        "香"
      end

      def promoted_name
        "杏"
      end

      def promoted_names
        super + ["成香"]
      end

      def basic_vectors2
        [[0, -1]]
      end
    end

    class Knight < Base
      include Goldable

      def name
        "桂"
      end

      def promoted_name
        "圭"
      end

      def promoted_names
        super + ["成桂"]
      end

      def basic_vectors1
        [[-1, -2], [1, -2]]
      end
    end

    class Silver < Base
      include Goldable

      def name
        "銀"
      end

      def promoted_name
        "全"
      end

      def promoted_names
        super + ["成銀"]
      end

      def basic_vectors1
        [
          [-1, -1], [0, -1], [1, -1],
          nil,          nil,     nil,
          [-1,  1],     nil, [1,  1],
        ]
      end
    end

    class Gold < Base
      def self.basic_pattern
        [
          [-1, -1], [0, -1], [1, -1],
          [-1,  0],          [1,  0],
          nil,      [0,  1],     nil,
        ]
      end

      def name
        "金"
      end

      def basic_vectors1
        self.class.basic_pattern
      end

      def promotable?
        false
      end
    end

    class King < Base
      def self.basic_pattern
        [
          [-1, -1], [0, -1], [1, -1],
          [-1,  0],     nil, [1,  0],
          [-1,  1], [0,  1], [1,  1],
        ]
      end

      def name
        "玉"
      end

      def basic_vectors1
        self.class.basic_pattern
      end

      def promotable?
        false
      end
    end
  end
end
