# -*- coding: utf-8 -*-
# 初期配置文字列のパース

require "./example_helper"

info = Utils.parse_str("７六と")
info[:piece].name # => "歩"
info[:promoted]   # => true
info[:point].name # => "7六"