class AddBasicProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :text
    add_column :users, :gender, :text
    add_column :users, :age, :date
    add_column :users, :about, :text
    add_column :users, :provider, :boolean
  end
end
