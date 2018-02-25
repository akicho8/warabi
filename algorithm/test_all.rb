require "test-unit"

require "./dirty_minimax"
require "./beauty_minimax"
require "./nega_max"
require "./nega_alpha"

class TestAll < Test::Unit::TestCase
  test "all" do
    histograms = [
      DirtyMinimax,
      BeautyMinimax,
      NegaMax,
      NegaAlpha,
    ].collect do |klass|
      mediator = klass.new
      mediator.params[:dimension] = 4
      mediator.params[:silent] = true
      mediator.params[:depth_max] = 3
      mediator.run
    end
    assert histograms.uniq.count == 1
  end
end
# >> Loaded suite -
# >> Started
# >> .
# >> Finished in 0.549346 seconds.
# >> -------------------------------------------------------------------------------
# >> 1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
# >> 100% passed
# >> -------------------------------------------------------------------------------
# >> 1.82 tests/s, 1.82 assertions/s
