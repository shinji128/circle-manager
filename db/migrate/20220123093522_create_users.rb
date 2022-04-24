class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uuid, null: false
      t.string :line_user_id, null: false
      t.string :name
      t.integer :role, null: false, default: 0

      t.timestamps
    end
    add_index :users, [:line_user_id, :uuid], unique: true
  end
end
