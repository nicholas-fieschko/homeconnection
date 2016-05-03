class EnforceAuthorForeignKeyOnReviews < ActiveRecord::Migration
  def change
    add_foreign_key :reviews, :users, column: :author_id
  end
end
