require 'active_support/core_ext/benchmark'

require "./dirty_minimax"
require "./beauty_minimax"
require "./nega_max"
require "./nega_alpha"

dimension = 4
(4..4).each do |dimension|
  (3..3).each do |depth_max|
    rows = [
      DirtyMinimax,
      BeautyMinimax,
      NegaMax,
      NegaAlpha,
    ].collect do |klass|
      strategy = klass.new
      strategy.params[:silent] = true
      strategy.params[:depth_max] = depth_max
      strategy.params[:dimension] = dimension
      ms = "%.2f" % Benchmark.ms { strategy.run }

      row = {}
      row[:model] = klass.name
      row.update(strategy.app.run_counts)
      row.update(strategy.app.histogram)
      row.update(ms: ms)
    end
    puts
    puts "** 盤面: #{dimension}x#{dimension}, 深さ: #{depth_max}"
    tp rows
  end
end
# >> ** 盤面: 4x4, 深さ: 3
# >> |---------------+--------+----------+---+----+-------|
# >> | model         | put_on | evaluate | o | x  | ms    |
# >> |---------------+--------+----------+---+----+-------|
# >> | DirtyMinimax  |    707 |      461 | 1 | 10 | 88.24 |
# >> | BeautyMinimax |    707 |      461 | 1 | 10 | 85.96 |
# >> | NegaMax       |    707 |      461 | 1 | 10 | 85.80 |
# >> | NegaAlpha     |    441 |      244 | 1 | 10 | 65.59 |
# >> |---------------+--------+----------+---+----+-------|
