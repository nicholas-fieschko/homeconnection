class Exchange < ActiveRecord::Base
  has_one :review
  belongs_to :provider, class_name: 'User'
  belongs_to :seeker,   class_name: 'User'

  def complete?
    self.s_finished && self.p_finished
  end
end
