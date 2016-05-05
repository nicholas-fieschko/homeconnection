class RemovePrivacyNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :privacy_name
  end
end
