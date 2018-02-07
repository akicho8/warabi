# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/piece_spec.rb" -*-
# frozen-string-literal: true
#
# 駒
#   Piece["歩"].key  # => :pawn
#
# 注意点
#   == を定義すると面倒なことになる
#   持駒の歩を取り出すため `player.pieces.delete(Piece["歩"])' としたとき歩が全部消えてしまう
#   同じ種類の駒、同じ種類の別の駒を分けて判別するためには == を定義しない方がいい
#

module Warabi
  class Piece
    concerning :UtilityMethods do
      class_methods do
        # Piece.s_to_a("飛0 角 竜1 馬2 龍2 飛").collect(&:name) # => ["飛", "飛", "飛", "飛", "角", "角", "角"]
        def s_to_a(str)
          s_to_h(str).yield_self { |v| h_to_a(v) }
        end

        # Piece.s_to_h("飛0 角 竜1 馬2 龍2") # => {:rook=>3, :bishop=>3}
        def s_to_h(str)
          str = str.tr("〇一二三四五六七八九", "0-9")
          str = str.remove(/\p{blank}/)
          str.scan(/(#{Piece.all_names.join("|")})(\d+)?/o).inject({}) do |a, (piece, count)|
            piece = Piece.fetch(piece)
            a.merge(piece.key => (count || 1).to_i) {|_, v1, v2| v1 + v2 }
          end
        end

        # Piece.h_to_a(rook: 2, bishop: 1).collect(&:name)      # => ["飛", "飛", "角"]
        def h_to_a(hash)
          hash.flat_map do |piece_key, count|
            count.times.collect { Piece.fetch(piece_key) }
          end
        end

        # Piece.h_to_s(bishop: 1, rook: 2) # => "飛二 角"
        def h_to_s(hash, **options)
          options = {
            ordered: true,      # 価値のある駒順に並べる
            separator: " ",
          }.merge(options)

          hash = hash.transform_keys { |e| Piece.fetch(e) }

          if options[:ordered]
            hash = hash.sort_by { |piece, _| -piece.basic_weight }
          end

          hash.map { |piece, count|
            raise MustNotHappen if count < 0
            if count > 1
              count = count.to_s.tr("0-9", "〇一二三四五六七八九")
            else
              count = ""
            end
            "#{piece.name}#{count}"
          }.join(options[:separator])
        end

        # Piece.a_to_s(["竜", :pawn, "竜"], ordered: true, separator: "/") # => "飛二/歩"
        def a_to_s(pieces, **options)
          pieces = pieces.collect { |e| Piece.fetch(e) }
          h_to_s(pieces.group_by(&:key).transform_values(&:size), options)
        end

        # Piece.s_to_h2("▲歩2 飛 △歩二飛 ▲金") # => {:black=>{:pawn=>2, :rook=>1, :gold=>1}, :white=>{:pawn=>2, :rook=>1}}
        def s_to_h2(str)
          hash = Location.inject({}) { |a, e| a.merge(e.key => []) }
          str.scan(/([#{Location.triangles_str}])([^#{Location.triangles_str}]+)/) do |triangle, str|
            location = Location[triangle]
            hash[location.key] << str
          end
          hash.transform_values { |e| s_to_h(e.join) }
        end
      end
    end

    include ApplicationMemoryRecord
    memory_record [
      {key: :king,   name: "玉", basic_alias: "王", promoted_name: nil,  promoted_alias: nil,    csa_basic_name: "OU", csa_promoted_name: nil,  sfen_char: "K", promotable: false, },
      {key: :rook,   name: "飛", basic_alias: nil,  promoted_name: "龍", promoted_alias: "竜",   csa_basic_name: "HI", csa_promoted_name: "RY", sfen_char: "R", promotable: true,  },
      {key: :bishop, name: "角", basic_alias: nil,  promoted_name: "馬", promoted_alias: nil,    csa_basic_name: "KA", csa_promoted_name: "UM", sfen_char: "B", promotable: true,  },
      {key: :gold,   name: "金", basic_alias: nil,  promoted_name: nil,  promoted_alias: nil,    csa_basic_name: "KI", csa_promoted_name: nil,  sfen_char: "G", promotable: false, },
      {key: :silver, name: "銀", basic_alias: nil,  promoted_name: "全", promoted_alias: "成銀", csa_basic_name: "GI", csa_promoted_name: "NG", sfen_char: "S", promotable: true,  },
      {key: :knight, name: "桂", basic_alias: nil,  promoted_name: "圭", promoted_alias: "成桂", csa_basic_name: "KE", csa_promoted_name: "NK", sfen_char: "N", promotable: true,  },
      {key: :lance,  name: "香", basic_alias: nil,  promoted_name: "杏", promoted_alias: "成香", csa_basic_name: "KY", csa_promoted_name: "NY", sfen_char: "L", promotable: true,  },
      {key: :pawn,   name: "歩", basic_alias: nil,  promoted_name: "と", promoted_alias: nil,    csa_basic_name: "FU", csa_promoted_name: "TO", sfen_char: "P", promotable: true,  },
    ]

    class << self
      def lookup(value)
        basic_group[value] || promoted_group[value] || super
      end

      def fetch(value)
        super
      rescue => error
        raise PieceNotFound, "#{value.inspect} に対応する駒がありません\n#{error.message}\nkeys: #{basic_group.keys.inspect}\nkeys: #{promoted_group.keys.inspect}"
      end

      def basic_group
        @basic_group ||= inject({}) { |a, e| a.merge(e.basic_names.collect { |key| [key, e] }.to_h) }
      end

      def promoted_group
        @promoted_group ||= inject({}) { |a, e| a.merge(e.promoted_names.collect { |key| [key, e] }.to_h) }
      end
    end

    def inspect
      "<#{self.class.name}:#{object_id} #{name} #{key}>"
    end

    # FIXME: 削除する
    def to_h
      [
        :name,
        :promoted_name,
        :basic_names,
        :promoted_names,
        :names,
        :key,
        :promotable,
        :basic_once_vectors,
        :basic_repeat_vectors,
        :promoted_once_vectors,
        :promoted_repeat_vectors,
      ].inject({}) do |a, e|
        a.merge(e => send(e))
      end
    end

    concerning :NameMethods do
      class_methods do
        def all_names
          @all_names ||= flat_map(&:names)
        end

        def all_basic_names
          @all_basic_names ||= flat_map(&:basic_names)
        end
      end

      def any_name(promoted)
        if promoted
          promoted_name
        else
          name
        end
      end

      def csa_some_name(promoted)
        if promoted
          csa_promoted_name
        else
          csa_basic_name
        end
      end

      def names
        basic_names + promoted_names
      end

      def basic_names
        [name, basic_alias, csa_basic_name, sfen_char, key].flatten.compact
      end

      def promoted_names
        [promoted_name, promoted_alias, csa_promoted_name].flatten.compact
      end
    end

    concerning :UsiMethods do
      class_methods do
        def fetch_by_sfen_char(ch)
          fetch(ch.upcase)
        end
      end

      def to_sfen(promoted: false, location: :black)
        location = Location[location]
        s = []
        if promoted
          s << "+"
        end
        s << sfen_char.public_send(location.key == :black ? :upcase : :downcase)
        s.join
      end
    end

    concerning :OtherMethods do
      def promotable?
        !!promotable
      end

      def assert_promotable(promoted)
        if !promotable? && promoted
          raise NotPromotable, "#{name}は成れない駒なのに成ろうとしています"
        end
      end
    end

    concerning :VectorMethods do
      included do
        delegate :brave?, :select_vectors, :select_vectors2, to: :piece_vector
      end

      def piece_vector
        @piece_vector ||= PieceVector[key]
      end
    end

    concerning :ScoreMethods do
      included do
        delegate :basic_weight, :promoted_weight, :hold_weight, to: :piece_score
      end

      def piece_score
        @piece_score ||= PieceScore[key]
      end
    end
  end
end
