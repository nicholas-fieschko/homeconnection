class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :public_comments
      t.text :private_comments
      t.integer :rating

      t.timestamps null: false
    end
  end
end
