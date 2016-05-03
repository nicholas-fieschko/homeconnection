class AddNeedProfilesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :food,      :boolean,  null: false, default: false
    add_column :users, :shelter,   :boolean,  null: false, default: false
    add_column :users, :transport, :boolean,  null: false, default: false
    add_column :users, :shower,    :boolean,  null: false, default: false
    add_column :users, :laundry,   :boolean,  null: false, default: false
    add_column :users, :buddy,     :boolean,  null: false, default: false
    add_column :users, :misc,      :boolean,  null: false, default: false

    add_column :users, :food_info,      :text
    add_column :users, :shelter_info,   :text
    add_column :users, :transport_info, :text
    add_column :users, :shower_info,    :text
    add_column :users, :laundry_info,   :text
    add_column :users, :buddy_info,     :text
    add_column :users, :misc_info,      :text

  end
end
