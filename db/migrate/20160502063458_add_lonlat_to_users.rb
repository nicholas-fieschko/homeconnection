class AddLonlatToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lonlat, :st_point, geographic: true
    add_index  :users, :lonlat, using: :gist
  end
end
