class AddUniquenessConstraintsToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, [:exchange_id, :author_id, :user_id], unique: true
  end
end
