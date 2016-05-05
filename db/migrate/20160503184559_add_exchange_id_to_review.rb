class AddExchangeIdToReview < ActiveRecord::Migration
  def change
    add_column      :reviews, :exchange_id, :integer
    add_foreign_key :reviews, :exchanges, column: :exchange_id
  end
end
