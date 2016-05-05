class CreateBlacklistings < ActiveRecord::Migration
  def change
    create_table :blacklistings do |t|
      t.integer :user_id
      t.integer :blocked_user

      t.timestamps null: false
    end
  end
end
