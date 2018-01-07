# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/utils_spec.rb" -*-
# frozen-string-literal: true
#
# 汎用の便利メソッド集
#

require "active_support/core_ext/object/to_query"

module Bushido
  module Utils
    extend self

    # 指定プレイヤー側の初期配置(「角落ち」などを指定可)
    # @example
    #   Utils.location_soldiers(location: location, key: "平手")
    #   Utils.location_soldiers(location: location, key: "+---...")
    def location_soldiers(params)
      params = {
        location: nil,
        key: nil,
      }.merge(params)

      location = Location[params[:location]]

      if BoardParser.accept?(params[:key])
        board_parser = BoardParser.parse(params[:key])
      else
        board_parser = PresetInfo.fetch(params[:key]).board_parser
      end

      board_parser.soldiers.collect do |e|
        e.merge(point: e[:point].reverse_if_white(location), location: location)
      end
    end

    # # 指定プレイヤー側の初期配置(盤面のみ対応)
    # # @example
    # #   Utils.location_soldiers(:black, "+----+\n|...") # => [...]
    # def __valid_both_battlers_from_char_board(params = {})
    #   params = {
    #     validate: true,
    #   }.merge(params)
    #
    #   if params[:validate]
    #     if v = params[:both_board_info][Location[:white]].presence
    #       raise BoardIsBlackOnly, "後手側データは定義できません: #{v.inspect}"
    #     end
    #   end
    #
    #   board_point_realize(params)
    # end

    # board_reset の引数の解釈
    #
    # @example
    #   board_reset_args("+-----")                              # そのまま棋譜が入ってれいばそのままパース
    #   board_reset_args("角落ち")                              # 先手だけが角落ち(下と同じ)
    #
    #   => {
    #       "▲" => [<Soldier>, ...],
    #       "△" => [<Soldier>, ...],
    #     }
    #
    def board_reset_args(value = nil)
      raise
    end

    # # {"▲" => "角落ち", "△" => "香落ち"} の場合(主にDSL用)
    # def board_reset_args_hash(hash)
    #   value.inject({}) {|a, (k, v)|
    #     a.merge(Location[k] => Utils.location_soldiers(location: k, key: v))
    #   }
    # end

    # 持駒表記変換 (コード → 人間表記)
    # @example
    #  Utils.hold_pieces_a_to_s([Piece["歩"], Piece["歩"], Piece["飛"]]) # => "歩二飛"
    def hold_pieces_a_to_s(pieces, **options)
      options = {
        ordered: false,         # 価値のある駒順に並べる
        separator: " ",
      }.merge(options)

      if options[:ordered]
        pieces = pieces.sort_by(&:basic_weight).reverse
      end

      pieces.group_by(&:key).collect { |key, pieces|
        count = pieces.size
        if count > 1
          count = count.to_s.tr("0-9", "〇一二三四五六七八九")
        else
          count = ""
        end
        "#{pieces.first.name}#{count}"
      }.join(options[:separator])
    end

    # 持駒表記変換 (人間表記 → コード)
    # @example
    #   Utils.hold_pieces_s_to_a("歩2 飛") # => [Piece["歩"], Piece["歩"], Piece["飛"]]
    def hold_pieces_s_to_a(str)
      if str.kind_of?(String)
        infos = __hold_pieces_s_to_a(str)
      else
        infos = str
      end
      piece_with_count_to_pieces(infos)
    end

    def __hold_pieces_s_to_a(str)
      str = str.tr("〇一二三四五六七八九", "0-9")
      str.scan(/(?<piece>#{Piece.all_basic_names.join("|")})(?<count>\d+)?/).collect do |piece, count|
        {piece: Piece.fetch(piece), count: (count || 1).to_i}
      end
    end

    # 適当な持駒文字列を先手後手に分離
    # @example
    #   Utils.triangle_hold_pieces_str_to_hash("▲歩2 飛 △歩二飛 ▲金") # => {Location[:black] => "歩2 飛 金", Location[:white] => "歩二飛 "}
    def triangle_hold_pieces_str_to_hash(str)
      hash = {}
      Array.wrap(str).join(" ").scan(/([#{Location.triangles_str}])([^#{Location.triangles_str}]+)/).each do |mark, pieces_str|
        location = Location[mark]
        hash[location] ||= []
        hash[location] << pieces_str
      end
      hash.transform_values(&:join)
    end

    # 先手後手に分離した持駒情報を文字列化
    # @example
    #   Utils.triangle_hold_pieces_hash_to_str({Location[:black] => "歩2 飛 金", Location[:white] => "歩二飛 "}) # => "▲歩2 飛 金 △歩二飛 "
    def triangle_hold_pieces_hash_to_str(hash)
      hash.collect{|location, pieces_str|"#{location.mark}#{pieces_str}"}.join(" ")
    end

    # ki2形式に近い棋譜の羅列のパース
    # @example
    #   ki2_parse("▲４二銀△４二銀") # => [{location: :black, input: "４二銀"}, {location: :white, input: "４二銀"}]
    def ki2_parse(str)
      str = str.to_s
      str = str.gsub(/([#{Location.triangles_str}])/, ' \1')
      str = str.squish
      str.split(/\s+/).collect{|s|
        if s.match?(/\A[#{Location.triangles_str}]/)
          movs_split(s)
        else
          s
        end
      }.flatten
    end

    def movs_split(str)
      regexp = /([#{Location.triangles_str}])([^#{Location.triangles_str}\s]+)/
      Array.wrap(str).join(" ").scan(regexp).collect{|mark, input|
        {location: Location[mark], input: input}
      }
    end

    def initial_battlers_split(str)
      movs_split(str.gsub(/_+/, " "))
    end

    def mov_split_one(str)
      md = str.match(/(?<mark>[#{Location.triangles_str}])(?<input>.*)/)
      # md or raise(ArgumentError)
      {location: Location[md[:mark]], input: md[:input]}
    end

    # Google検索用URL
    # @example
    #   guguru_url("UFO銀")
    #   guguru_url(["UFO銀", "急戦"])
    def guguru_url(keywords)
      str = Array.wrap(keywords).compact.uniq.join(" ")
      "https://www.google.co.jp/search?source=ig&hl=ja&lr=lang_ja&#{{q: str.tosjis}.to_query}"
    end

    # # 後手のみ先手用になっている初期駒配置を反転させる
    # def board_point_realize(params)
    #   params[:both_board_info].inject({}) do |a, (key, value)|
    #     a.merge(key => value.collect { |s| s.merge(point: s[:point].reverse_if_white(params[:location])) })
    #   end
    # end

    # soldiers を location 側の配置に変更したのを返す
    def board_point_realize2(soldiers, location)
      soldiers.collect { |e| e.merge(point: e[:point].reverse_if_white(location)) }
    end

    private

    def piece_with_count_to_pieces(list)
      Array.wrap(list).collect { |info|
        (info[:count] || 1).times.collect { Piece.fetch(info[:piece]) }
      }.flatten
    end
  end
end
