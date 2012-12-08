# -*- coding: utf-8 -*-

require "spec_helper"

module Bushido
  describe Bushido do
    it do
      @field = Field.new
      @players = []
      @players << Player.new("先手", @field, :lower)
      @players << Player.new("後手", @field, :upper)
      @players.each(&:setup)
      # puts @field.to_s
      @players[0].move_to("7七", "7六")
      # puts @field.to_s
      @players[1].move_to("3三", "3四")
      # puts @field.to_s
      @players[0].move_to("8八", "2二")
      # puts @field.to_s

      # p Point.parse("4三").name
      # p Point.parse("４三").name
      # p Point.parse("43").name
      #
      # p Point.parse("4三").to_xy # => [5, 2]
    end
  end
end
