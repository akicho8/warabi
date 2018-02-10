# frozen-string-literal: true

module Warabi
  concern :MediatorPlayers do
    class_methods do
      # 先手後手が座った状態で開始
      def start
        mediator = new
        mediator.players.each(&:pieces_add)
        mediator
      end
    end

    attr_accessor :players

    def initialize(*args)
      super

      @players = Location.collect do |e|
        Player.new(self, location: e)
      end
    end

    def player_at(location)
      @players[Location[location].index]
    end

    def current_player(diff = 0)
      players[turn_info.current_location(diff).code]
    end

    def reverse_player
      current_player(1)
    end

    def next_player
      reverse_player
    end

    # プレイヤーたちの持駒から平手用の盤面の準備
    def piece_plot
      @players.each(&:piece_plot)
    end

    # プレイヤーたちの持駒を捨てる
    def piece_box_clear
      @players.collect { |e| e.piece_box.clear }
    end

    def win_player
      reverse_player
    end

    def lose_player
      current_player
    end

    concerning :Other do
      # 両者の駒の配置を決める
      # @example 持駒から配置する場合(持駒がなければエラーになる)
      #   soldiers_create("▲３三歩 △１一歩")
      # @example 持駒から配置しない場合(無限に駒が置ける)
      #   soldiers_create("▲３三歩 △１一歩", from_stand: false)
      def soldiers_create(str, **options)
        Utils.initial_soldiers_split(str).each do |info|
          player_at(info[:location]).soldiers_create(info[:input], options)
        end
      end

      # 一般の持駒表記で両者に駒を配る
      # @example
      #   mediator.pieces_set("▲歩2 飛 △歩二飛 ▲金")
      def pieces_set(str)
        Piece.s_to_h2(str).each do |location_key, counts|
          player_at(location_key).piece_box.set(counts)
        end
      end
    end
  end
end