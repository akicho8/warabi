# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/piece_spec.rb" -*-
# frozen-string-literal: true
#
# 駒
#   Piece["歩"].name  # => "歩"
#   Piece[:pawn].name # => "歩"
#   Piece.each{|piece|...}
#
# 意味
#   basic_once_vectors      通常の1ベクトル
#   basic_repeat_vectors    通常の繰り返しベクトル
#   promoted_once_vectors   成ったときの1ベクトル
#   promoted_repeat_vectors 成ったときの繰り返しベクトル
#
# 注意点
#   == を定義すると面倒なことになる
#   持駒の歩を取り出すため `player.pieces.delete(Piece["歩"])' としたとき歩が全部消えてしまう
#   同じ種類の駒、同じ種類の別の駒を分けて判別するためには == を定義しない方がいい
#

module Bushido
  class Piece
    include ApplicationMemoryRecord
    memory_record [
      {key: :king,   name: "玉", basic_alias: "王", promoted_name: nil,  promoted_alias: nil,    csa_basic_name: "OU", csa_promoted_name: nil,  sfen_char: "K", basic_once_vectors: :pattern_king,       basic_repeat_vectors: nil,           promotable: false, promoted_once_vectors: nil,           promoted_repeat_vectors: nil,           basic_weight: 9999, promoted_weight: 0,    mochigoma_weight: 9999},
      {key: :rook,   name: "飛", basic_alias: nil,  promoted_name: "龍", promoted_alias: "竜",   csa_basic_name: "HI", csa_promoted_name: "RY", sfen_char: "R", basic_once_vectors: nil,                 basic_repeat_vectors: :pattern_plus, promotable: true,  promoted_once_vectors: :pattern_x,    promoted_repeat_vectors: :pattern_plus, basic_weight: 2000, promoted_weight: 2200, mochigoma_weight: 2100},
      {key: :bishop, name: "角", basic_alias: nil,  promoted_name: "馬", promoted_alias: nil,    csa_basic_name: "KA", csa_promoted_name: "UM", sfen_char: "B", basic_once_vectors: nil,                 basic_repeat_vectors: :pattern_x,    promotable: true,  promoted_once_vectors: :pattern_plus, promoted_repeat_vectors: :pattern_x,    basic_weight: 1800, promoted_weight: 2000, mochigoma_weight: 1890},
      {key: :gold,   name: "金", basic_alias: nil,  promoted_name: nil,  promoted_alias: nil,    csa_basic_name: "KI", csa_promoted_name: nil,  sfen_char: "G", basic_once_vectors: :pattern_gold,       basic_repeat_vectors: nil,           promotable: false, promoted_once_vectors: nil,           promoted_repeat_vectors: nil,           basic_weight: 1200, promoted_weight: 0,    mochigoma_weight: 1260},
      {key: :silver, name: "銀", basic_alias: nil,  promoted_name: "全", promoted_alias: "成銀", csa_basic_name: "GI", csa_promoted_name: "NG", sfen_char: "S", basic_once_vectors: :pattern_silver,     basic_repeat_vectors: nil,           promotable: true,  promoted_once_vectors: :pattern_gold, promoted_repeat_vectors: nil,           basic_weight: 1000, promoted_weight: 1200, mochigoma_weight: 1050},
      {key: :knight, name: "桂", basic_alias: nil,  promoted_name: "圭", promoted_alias: "成桂", csa_basic_name: "KE", csa_promoted_name: "NK", sfen_char: "N", basic_once_vectors: [[-1, -2], [1, -2]], basic_repeat_vectors: nil,           promotable: true,  promoted_once_vectors: :pattern_gold, promoted_repeat_vectors: nil,           basic_weight:  700, promoted_weight: 1200, mochigoma_weight:  735},
      {key: :lance,  name: "香", basic_alias: nil,  promoted_name: "杏", promoted_alias: "成香", csa_basic_name: "KY", csa_promoted_name: "NY", sfen_char: "L", basic_once_vectors: nil,                 basic_repeat_vectors: [[0, -1]],     promotable: true,  promoted_once_vectors: :pattern_gold, promoted_repeat_vectors: nil,           basic_weight:  600, promoted_weight: 1200, mochigoma_weight:  630},
      {key: :pawn,   name: "歩", basic_alias: nil,  promoted_name: "と", promoted_alias: nil,    csa_basic_name: "FU", csa_promoted_name: "TO", sfen_char: "P", basic_once_vectors: [[0, -1]],           basic_repeat_vectors: nil,           promotable: true,  promoted_once_vectors: :pattern_gold, promoted_repeat_vectors: nil,           basic_weight:  100, promoted_weight: 1200, mochigoma_weight:  105},
    ]

    class << self
      # 駒オブジェクトを得る
      #   Piece.lookup(nil)       # => nil
      #   Piece.lookup("歩").name # => "歩"
      #   Piece.lookup("と").name # => "歩"
      #   「と」も「歩」も区別しない。区別したい場合は new_with_promoted を使うこと
      #   エラーにしたいときは fetch を使う
      def lookup(arg)
        super || basic_lookup(arg) || promoted_lookup(arg)
      end

      # alias [] lookup
      # alias get lookup

      # Piece.fetch("歩").name # => "歩"
      # Piece.fetch("卍")      # => PieceNotFound
      def fetch(arg)
        super
      rescue => error
        raise PieceNotFound, "#{arg.inspect} に対応する駒がありません\n#{error.message}"
      end

      # 「歩」や「と」を駒オブジェクトと成フラグに分離
      #   Soldier.new_with_promoted("歩") # => <Soldier piece:"歩">
      #   Soldier.new_with_promoted("と") # => <Soldier piece:"歩", promoted: true>
      # def new_with_promoted(arg)
      #   case
      #   when piece = basic_lookup(arg)
      #     Soldier[piece: piece, promoted: false]
      #   when piece = promoted_lookup(arg)
      #     Soldier[piece: piece, promoted: true]
      #   else
      #     raise PieceNotFound, "#{arg.inspect} に対応する駒がありません"
      #   end
      # end

      # # FIXME: 速くする
      # def csa_new_with_promoted(arg)
      #   case
      #   when piece = find{|e|e.csa_basic_name == arg}
      #     Soldier[piece: piece, promoted: false]
      #   when piece = find{|e|e.csa_promoted_name == arg}
      #     Soldier[piece: piece, promoted: true]
      #   else
      #     raise PieceNotFound, "#{arg.inspect} に対応する駒がありません"
      #   end
      # end

      # 台上の持駒文字列をハッシュ配列化
      #   hold_pieces_s_to_a("飛 香二") # => [{piece: Piece["飛"], count: 1}, {piece: Piece["香"], count: 2}]
      def hold_pieces_s_to_a(*args)
        Utils.hold_pieces_s_to_a(*args)
      end

      def basic_lookup(arg)
        find { |piece| piece.basic_names.include?(arg.to_s) } # FIXME: 遅い
      end

      def promoted_lookup(arg)
        find { |piece| piece.promoted_names.include?(arg.to_s) } # FIXME: 遅い
      end
    end

    def inspect
      "<#{self.class.name}:#{object_id} #{name} #{key}>"
    end

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
          @all_names ||= collect(&:names).flatten
        end

        def all_basic_names
          @all_basic_names ||= collect(&:basic_names).flatten
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

      def to_sfen(promoted: false, location: Location[:black])
        s = []
        if promoted
          s << "+"
        end
        s << sfen_char.public_send(location.key == :black ? :upcase : :downcase)
        s.join
      end

      # 名前すべて
      def names
        basic_names + promoted_names
      end

      # 成ってないときの名前たち
      def basic_names
        [name, basic_alias].flatten.compact
      end

      # 成ったときの名前たち
      # 「キーの大文字」を成名としているのはおまけ
      def promoted_names
        [promoted_name, promoted_alias].flatten.compact
      end
    end

    concerning :UsiMethods do
      class_methods do
        # 大文字小文字の差は見てない
        def fetch_by_sfen_char(ch)
          @fetch_by_sfen_char ||= inject({}) { |a, e| a.merge(e.sfen_char => e) }
          @fetch_by_sfen_char.fetch(ch.upcase)
        end
      end

      def to_sfen(promoted: false, location: Location[:black])
        s = []
        if promoted
          s << "+"
        end
        s << sfen_char.public_send(location.key == :black ? :upcase : :downcase)
        s.join
      end
    end

    concerning :OtherMethods do
      # 飛角か？
      def brave?
        attributes[:promoted_repeat_vectors]
      end

      # 成れる駒か？
      def promotable?
        !!promotable
      end

      def assert_promotable(v)
        if !promotable? && v
          raise NotPromotable, "成れない駒で成ろうとしています : #{piece.inspect}"
        end
      end
    end

    concerning :VectorMethods do
      def select_vectors(promoted)
        assert_promotable(promoted)

        if promoted
          promoted_vectors
        else
          basic_vectors
        end
      end

      def select_vectors2(promoted:, location:)
        @select_vectors2 ||= {}
        @select_vectors2[[promoted, location]] ||=
          begin
            vectors = select_vectors(promoted)
            normalized_vectors(location, vectors)
          end
      end

      private

      def normalized_vectors(location, vectors)
        if location.white?
          vectors.collect(&:reverse_sign)
        else
          vectors
        end
      end

      # 通常の合成ベクトル
      def basic_vectors
        @basic_vectors ||= build_vectors(basic_once_vectors, basic_repeat_vectors)
      end

      # 成ったときの合成ベクトル
      def promoted_vectors
        @promoted_vectors ||= build_vectors(promoted_once_vectors, promoted_repeat_vectors)
      end

      def build_vectors(ov, rv)
        v = ov.compact + rv.compact
        if v.size != v.uniq.size
          raise MustNotHappen
        end

        [
          *ov.compact.collect { |v| OnceVector[*v]   },
          *rv.compact.collect { |v| RepeatVector[*v] },
        ].to_set
      end

      def basic_once_vectors
        __vectors_at(super)
      end

      def basic_repeat_vectors
        __vectors_at(super)
      end

      def promoted_once_vectors
        __vectors_at(super)
      end

      def promoted_repeat_vectors
        __vectors_at(super)
      end

      def __vectors_at(value)
        if value
          if value.kind_of?(Symbol)
            send(value)
          else
            value
          end
        else
          []
        end
      end

      def pattern_plus
        [
          nil,    [0,-1],   nil,
          [-1, 0],       [1, 0],
          nil,    [0, 1],   nil,
        ]
      end

      def pattern_x
        [
          [-1, -1], nil, [1, -1],
          nil,      nil,     nil,
          [-1,  1], nil, [1,  1],
        ]
      end

      def pattern_silver
        [
          [-1, -1], [0, -1], [1, -1],
          nil,          nil,     nil,
          [-1,  1],     nil, [1,  1],
        ]
      end

      def pattern_gold
        [
          [-1, -1], [0, -1], [1, -1],
          [-1,  0],          [1,  0],
          nil,      [0,  1],     nil,
        ]
      end

      def pattern_king
        [
          [-1, -1], [0, -1], [1, -1],
          [-1,  0],     nil, [1,  0],
          [-1,  1], [0,  1], [1,  1],
        ]
      end
    end
  end
end
