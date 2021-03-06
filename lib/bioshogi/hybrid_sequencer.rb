# frozen-string-literal: true

module Bioshogi
  module HybridSequencer
    def self.execute(pattern)
      if pattern[:notation_dsl]
        mediator = Sequencer.new
        mediator.pattern = pattern[:notation_dsl]
        mediator.evaluate
        mediator.snapshots
      else
        Simulator.run(pattern)
      end
    end
  end
end
