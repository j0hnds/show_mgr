class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :phoneable, :polymorphic => true
      t.string :phone_type, :limit => 20
      t.string :phone_number, :limit => 15

      t.timestamps
    end
  end
end
