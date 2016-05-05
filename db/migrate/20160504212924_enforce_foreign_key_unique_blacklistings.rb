class EnforceForeignKeyUniqueBlacklistings < ActiveRecord::Migration
  def change
    rename_column   :blacklistings, :blocked_user, :blocked_user_id

    add_foreign_key :blacklistings, :users, column: :user_id
    add_foreign_key :blacklistings, :users, column: :blocked_user_id

    add_index :blacklistings, [:user_id, :blocked_user_id], unique: true
  end
end
