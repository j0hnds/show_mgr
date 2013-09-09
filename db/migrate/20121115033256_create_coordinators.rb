class CreateCoordinators < ActiveRecord::Migration
  def change
    create_table :coordinators do |t|
      t.string :first_name, :limit => 40
      t.string :last_name, :limit => 40

      t.timestamps
    end
  end
end
