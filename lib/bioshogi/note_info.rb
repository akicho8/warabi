# frozen-string-literal: true

module Bioshogi
  class NoteInfo
    include ApplicationMemoryRecord
    memory_record [
      { wars_code: nil, key: "入玉",      trigger_piece_key: {piece_key: :king,   promoted: false, motion: :move}, parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },

      { wars_code: nil, key: "居飛車",    parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil, skip_if_exist_keys: "振り飛車", },
      { wars_code: nil, key: "振り飛車",  parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil, skip_if_exist_keys: "居飛車",   },

      # トリガーはもっていないシリーズ
      { wars_code: nil, key: "相入玉",             parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },
      { wars_code: nil, key: "大駒全消失",         parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },
      { wars_code: nil, key: "居玉",               parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },
      { wars_code: nil, key: "相居玉",             parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },

      { wars_code: nil, key: "相居飛車",           parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },
      { wars_code: nil, key: "対振り",             parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },
      { wars_code: nil, key: "相振り",             parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },
      { wars_code: nil, key: "対抗型",             parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },

      # { wars_code: nil, key: "駒柱",               parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },

      { wars_code: nil, key: "大駒コンプリート", piece_box_added_proc: -> note_info, captured_soldier {
          if captured_soldier.piece.stronger
            c = 0
            c += piece_box[:rook] || 0
            c += piece_box[:bishop] || 0

            location_key = player.location.key
            c += board.piece_counts(location_key, :rook)
            c += board.piece_counts(location_key, :bishop)

            retv = c >= 4

            # 相手にも追加
            if retv
              player.opponent_player.skill_set.list_push(NoteInfo["大駒全消失"])
              # list << note_info
              # skill_set.list_of(e) << note_info
            end

            retv
          end
        }, parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },

      { wars_code: nil, key: "駒柱", every_time_proc: -> note_info {
          retv = player.board.piece_piller_by_latest_piece
          if retv
            player.opponent_player.skill_set.list_push(note_info)
          end
          retv
        }, parent: nil, other_parents: nil, alias_names: nil, turn_limit: nil, turn_eq: nil, order_key: nil, not_have_pawn: nil, kill_only: nil, drop_only: nil, not_have_anything_except_pawn: nil, cold_war: nil,  hold_piece_not_in: nil, hold_piece_in: nil, hold_piece_empty: nil, hold_piece_eq: nil,  },
    ]

    include PresetInfo::DelegateToShapeInfoMethods
    include DefenseInfo::AttackInfoSharedMethods
  end
end
