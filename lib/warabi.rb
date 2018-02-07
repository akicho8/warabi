require_relative "warabi/version"

require "active_support/logger"
require "active_support/configurable"
require "active_support/core_ext/array/wrap"
require "active_support/core_ext/class/attribute"
require "active_support/core_ext/class/attribute_accessors"
require "active_support/core_ext/module/attribute_accessors"
require "active_support/core_ext/string"

require "active_support/dependencies/autoload"
require "active_support/core_ext/array/grouping" # for in_groups_of
require "active_support/core_ext/numeric"        # for 1.minute

require "active_model"

require "time"                  # for Time.parse
require "kconv"                 # for toeuc

require "org_tp"
require "memory_record"

module Warabi
  include ActiveSupport::Configurable
  config_accessor(:skill_set_flag) { true }
end

require_relative "warabi/logger"
require_relative "warabi/vector"
require_relative "warabi/errors"
require_relative "warabi/application_memory_record"
require_relative "warabi/position"
require_relative "warabi/point"
require_relative "warabi/location"
require_relative "warabi/turn_info"
require_relative "warabi/order_info"
require_relative "warabi/piece"
require_relative "warabi/piece_vector"
require_relative "warabi/piece_score"
require_relative "warabi/piece_box"
require_relative "warabi/hand_log"

require_relative "warabi/soldier"
require_relative "warabi/board_parser"
require_relative "warabi/kakiki_format"
require_relative "warabi/csa_board_format"
require_relative "warabi/board"
require_relative "warabi/utils"

require_relative "warabi/xtra_pattern"
require_relative "warabi/battler"
require_relative "warabi/defense_info"
require_relative "warabi/attack_info"
require_relative "warabi/skill_set"
require_relative "warabi/tactic_info"
require_relative "warabi/tactic_urls_info"
require_relative "warabi/skill_monitor"
require_relative "warabi/player"
require_relative "warabi/runner"
require_relative "warabi/movabler"
require_relative "warabi/kifu_dsl"
require_relative "warabi/mediator"

require_relative "warabi/shape_info"
require_relative "warabi/preset_info"
require_relative "warabi/sect_info"
require_relative "warabi/defense_group_info"

require_relative "warabi/brain"
require_relative "warabi/evaluator"

require_relative "warabi/parser"

require_relative "warabi/sfen"
require_relative "warabi/usi"
