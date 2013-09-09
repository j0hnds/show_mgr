class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :emailable, :polymorphic => true
      t.string :email_type, :limit => 10
      t.string :address, :limit => 255

      t.timestamps
    end
  end
end
