class CreateCircles < ActiveRecord::Migration[6.1]
  def change
    create_table :circles do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :introduction
      t.integer :state, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :circles, :uuid, unique: true
  end
end
