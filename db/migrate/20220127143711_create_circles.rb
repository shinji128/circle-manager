class CreateCircles < ActiveRecord::Migration[6.1]
  def change
    create_table :circles do |t|
      t.string :uuid
      t.string :name
      t.string :introduction
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
