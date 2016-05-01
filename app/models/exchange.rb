class Exchange < ActiveRecord::Base

  def complete?
    self.s_finished && self.p_finished
  end
end
