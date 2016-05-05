class AddPrivacySettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privacy_email,          :integer
    add_column :users, :privacy_location,       :integer
    add_column :users, :privacy_activity,       :integer
    add_column :users, :privacy_name,           :integer
    add_column :users, :privacy_gender,         :integer
    add_column :users, :privacy_age,            :integer
    add_column :users, :privacy_about,          :integer
    add_column :users, :privacy_resources,      :integer
    add_column :users, :privacy_resources_info, :integer
    add_column :users, :privacy_exchanges,      :integer
  end
end
