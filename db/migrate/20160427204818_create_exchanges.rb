class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.integer :provider_id, null: false
      t.integer :seeker_id,   null: false
      t.boolean :s_accepted,  null: false, default: false
      t.boolean :p_accepted,  null: false, default: false
      t.boolean :s_finished,  null: false, default: false
      t.boolean :p_finished,  null: false, default: false

      t.timestamps null: false
    end
  end
end
