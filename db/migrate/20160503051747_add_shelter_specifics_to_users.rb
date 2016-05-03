class AddShelterSpecificsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shelter_accessible, :boolean,  null: false, default: false
    add_column :users, :shelter_pets,       :boolean,  null: false, default: false
  end
end
