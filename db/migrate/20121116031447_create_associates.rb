class CreateAssociates < ActiveRecord::Migration
  def change
    create_table :associates do |t|
      t.integer :room_id, :null => false
      t.string :first_name, :limit => 40
      t.string :last_name, :limit => 40

      t.timestamps
    end
  end
end
