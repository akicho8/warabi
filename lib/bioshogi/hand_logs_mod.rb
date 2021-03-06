# frozen-string-literal: true

module Bioshogi
  concern :HandLogsMod do
    def turn_ended_process
      super

      mediator.hand_logs << hand_log
    end

    def hand_log
      @hand_log ||= HandLog.new({
          :drop_hand      => @drop_hand,
          :move_hand      => @move_hand,
          :candidate      => @candidate_soldiers,
          :place_same     => place_same?,
          :skill_set      => skill_set,
          :handicap       => mediator.turn_info.handicap?,
          :personal_clock => player.personal_clock.clone.freeze, # 時計の状態を保持して手に結びつける
        }).freeze
    end

    def place_same?
      if hand_log = mediator.hand_logs.last
        hand_log.soldier.place == soldier.place
      end
    end
  end
end
