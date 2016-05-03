class AddRelationshipsToReviews < ActiveRecord::Migration
  def change
    add_reference   :reviews, :user, index: true
    add_foreign_key :reviews, :users
    add_column      :reviews, :author_id, :integer
  end
end
