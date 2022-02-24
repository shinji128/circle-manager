class CreateCircles < ActiveRecord::Migration[6.1]
  def change
    create_table :circles do |t|
      t.string :uuid, null: false, unique: true
      t.string :name, null: false
      t.string :introduction
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
