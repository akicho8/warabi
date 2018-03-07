# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/brain_spec.rb" -*-
# frozen-string-literal: true

require "timeout"

module Warabi
  class Brain
    def self.human_format(infos)
      infos.collect.with_index do |e, i|
        {
          "順位"       => i.next,
          "候補手"     => e[:hand],
          "読み筋"     => e[:forecast].collect { |e| e.to_s }.join(" "),
          "形勢"       => e[:score2],
          "評価局面数" => e[:eval_times],
          "処理時間"   => e[:sec],
        }
      end
    end

    attr_accessor :player, :params

    def initialize(player, **params)
      @player = player
      @params = {
        default_diver_class: NegaAlphaDiver, # [NegaAlphaDiver, NegaScoutDiver]
      }.merge(params)
    end

    def diver_dive(**params)
      self.params[:default_diver_class].new(params.merge(current_player: player)).dive
    end

    def interactive_deepning(**params)
      params = {
        depth_max_range: 1..1,
        time_limit: nil,        # nil: 時間制限なし
      }.merge(params)

      if params[:time_limit]
        params[:out_of_time] ||= Time.now + params[:time_limit]
      end

      children = lazy_all_hands.to_a # 何度も実行するためあえて配列化しておくの重要
      hands = []
      finished = catch params[:out_of_time] do
        params[:depth_max_range].each do |depth_max|
          diver = self.params[:default_diver_class].new(params.merge(current_player: player.opponent_player, depth_max: depth_max))
          hands = children.collect do |hand|
            Warabi.logger.debug "試指 #{hand}" if Warabi.logger
            hand.sandbox_execute(player.mediator) do
              start_time = Time.now
              v, way = diver.dive
              {hand: hand, score: -v, score2: -v * player.location.value_sign, forecast: way, eval_times: diver.eval_counter, sec: Time.now - start_time}
            end
          end
        end
        true
      end

      if !children.empty? && hands.empty?
        raise WarabiError, "指し手の候補を絞れません。制限時間を増やすか読みの深度を浅くしてください : #{params}"
      end

      hands.sort_by { |e| -e[:score] }
    end

    def smart_score_list(**params)
      diver = self.params[:default_diver_class].new(params.merge(current_player: player.opponent_player))
      lazy_all_hands.collect { |hand|
        hand.sandbox_execute(player.mediator) do
          start_time = Time.now
          v, way = diver.dive
          {hand: hand, score: -v, socre2: -v * player.location.value_sign, forecast: way, eval_times: diver.eval_counter, sec: Time.now - start_time}
        end
      }.sort_by { |e| -e[:score] }
    end

    def fast_score_list(**params)
      lazy_all_hands.collect { |hand|
        hand.sandbox_execute(player.mediator) do
          start_time = Time.now
          v = player.evaluator.score
          {hand: hand, score: v, socre2: v * player.location.value_sign, forecast: [], eval_times: 1, sec: Time.now - start_time}
        end
      }.sort_by { |e| -e[:score] }
    end

    def lazy_all_hands
      Enumerator.new do |y|
        move_hands.each do |e|
          y << e
        end
        drop_hands.each do |e|
          y << e
        end
      end
    end

    # 盤上の駒の全手筋
    def move_hands
      Enumerator.new do |y|
        player.soldiers.each do |soldier|
          soldier.move_list(player.board, promoted_preferred: true).each do |move_hand|
            y << move_hand
          end
        end
      end
    end

    # 持駒の全打筋
    def drop_hands
      Enumerator.new do |y|
        # 直接 piece_box.each_key とせずに piece_keys にいったん取り出している理由は
        # 外側で execute 〜 revert するときの a.each { a.update } の状態になるのを回避するため。
        # each の中で元を更新すると "can't add a new key into hash during iteration" のエラーになる
        piece_keys = player.piece_box.keys
        player.board.blank_points.each do |point|
          piece_keys.each do |piece_key|
            soldier = Soldier.create(piece: Piece[piece_key], promoted: false, point: point, location: player.location)
            if soldier.rule_valid?(player.board)
              y << DropHand.create(soldier: soldier)
            end
          end
        end
      end
    end
  end

  class HandInfo < Hash
    def to_s
      "#{self[:hand]} => #{self[:score]}"
    end
  end

  class Diver
    attr_accessor :params
    attr_accessor :eval_counter

    # delegate :mediator, to: :player
    # delegate :evaluate, to: :mediator
    # delegate :put_on, to: :mediator

    def initialize(params)
      @params = {
        depth_max: 0,           # 最大の深さ
        log_skip_depth: nil,
      }.merge(params)

      @eval_counter = 0
    end

    private

    def logger_info(str, context)
      return unless logger

      if v = params[:log_skip_depth]
        if context[:depth] >= v
          return
        end
      end

      str = str.lines.collect { |e|
        (" " * 4 * context[:depth]) + e
      }.join.rstrip

      if str.match?(/\n/)
        str = "\n" + str
      end

      Warabi.logger.info "    %d %s %s" % [
        context[:depth],
        context[:player].location,
        str,
      ]
    end

    def logger
      Warabi.logger
    end

    def out_of_time_check
      if time = params[:out_of_time]
        if time && time <= Time.now
          throw time
        end
      end
    end

    def depth_max
      params[:depth_max]
    end
  end

  class NegaAlphaDiver < Diver
    def dive(player = params[:current_player], depth = 0, alpha = -Float::INFINITY, beta = Float::INFINITY)
      out_of_time_check

      mediator = player.mediator

      if depth == 0
        @eval_counter = 0
      end

      if logger
        log = -> s { logger_info(s, player: player, depth: depth) }
      end

      if depth_max <= depth
        @eval_counter += 1
        score = player.evaluator.score
        log.call "評価 #{score}" if log
        return [score, []]
      end

      children = player.brain.lazy_all_hands

      best_hand = nil
      forecast = nil
      children_exist = false

      children.each.with_index do |hand, i|
        children_exist = true
        log.call "試指 #{hand} (%d)" % i if log
        hand.sandbox_execute(mediator) do
          v, way = dive(player.opponent_player, depth + 1, -beta, -alpha)
          v = -v
          if alpha < v
            alpha = v
            best_hand = hand
            forecast = way
          end
        end
        if alpha >= beta
          break
        end
      end

      # unless children_exist
      #   raise WarabiError, "#{player.call_name}の指し手が一つもありません。すべての駒を取られている可能性があります\n#{mediator.to_bod}"
      # end

      log.call "★確 #{best_hand}" if log

      [alpha, [best_hand, *forecast]]
    end
  end

  class NegaScoutDiver < Diver
    def dive(player = params[:current_player], depth = 0, alpha = -Float::INFINITY, beta = Float::INFINITY)
      out_of_time_check

      mediator = player.mediator

      if depth == 0
        @eval_counter = 0
      end

      if logger
        log = -> s { logger_info(s, player: player, depth: depth) }
      end

      if depth_max <= depth
        @eval_counter += 1
        score = player.evaluator.score
        log.call "評価 #{score}" if log
        return [score, []]
      end

      children = player.brain.lazy_all_hands

      # # 合法手がない場合はパスして相手に手番を渡す
      # if children.empty?
      #   v, way = dive(player.opponent_player, depth + 1, -beta, -alpha)
      #   v = -v
      #   return [v, [:pass, *way]]
      # end

      # 再帰を簡潔に記述するため
      recursive = -> hand, alpha2, beta2 {
        log.call "試指 #{hand}" if log
        hand.sandbox_execute(mediator) do
          v, way = dive(player.opponent_player, depth + 1, alpha2, beta2)
          v = -v
          [v, way]
        end
      }

      forecast = []

      if false
        max_v = -Float::INFINITY
      else
        # 効果的なもの順に並び換える
        # children = mediator.move_ordering(player, children)
        children = children.to_a # FIXME: 並び返るために全取得すると遅延評価にした意味がない

        # 最善候補を通常の窓で探索
        hand = children.shift
        v, way = recursive.(hand, -beta, -alpha)
        max_v = v
        forecast = [hand, *way]
        if beta <= v
          return [v, [hand, *way]]
        end
        if alpha < v
          alpha = v
        end
      end

      children.each do |hand|
        v, way = recursive.(hand, -(alpha + 1), -alpha) # null window search
        if beta <= v
          return [v, [hand, *way]]
        end
        if alpha < v
          alpha = v
          v, way = recursive.(hand, -beta, -alpha) # 通常の窓で再探索
          if beta <= v
            return [v, [hand, *way]]
          end
          if alpha < v
            alpha = v
          end
        end
        if max_v < v
          max_v = v
          forecast = [hand, *way]
        end
      end

      log.call "★確 #{forecast.first || '?'}" if log
      [max_v, forecast]
    end
  end
end
