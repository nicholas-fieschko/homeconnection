class RenameAgeFieldToBirthdate < ActiveRecord::Migration
  def change
    rename_column :users, :age, :birthday
  end
end
