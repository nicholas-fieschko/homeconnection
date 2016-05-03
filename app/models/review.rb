class Review < ActiveRecord::Base
  belongs_to :user
  has_one    :author, :class_name => 'User', :foreign_key => 'author_id'
end
