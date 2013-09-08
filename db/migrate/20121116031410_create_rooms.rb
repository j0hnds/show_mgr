class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :registration_id, :null => false
      t.string :room, :limit => 10

      t.timestamps
    end
  end
end
