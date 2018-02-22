require_relative "spec_helper"

module Warabi
  describe MediatorStack do
    it do
      object = MediatorStack.new
      object.mediator.board.placement_from_preset
      object.mediator.execute("▲７六歩")
      object.stack_push
      object.mediator.execute("△３四歩")
      object.stack_pop

      object = MediatorStack.new
      object.mediator.object_id
      object_id = object.mediator.object_id
      object.stack_push
      (object.mediator.object_id != object_id).should == true
      object.stack_pop
      object.mediator.object_id
      (object.mediator.object_id == object_id).should == true
    end
  end
end