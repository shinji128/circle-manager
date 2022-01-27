class CreateUserCircles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_circles do |t|
      t.string :uuid
      t.string :introduction
      t.integer :register_state
      t.references :user, null: false, foreign_key: true
      t.references :circle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
