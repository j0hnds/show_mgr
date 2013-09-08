class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :show_id, :null => false
      t.integer :buyer_id, :null => false

      t.timestamps
    end
  end
end
