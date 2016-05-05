class AddPrivacyNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privacy_name, :integer
  end
end
