class CreateAffiliations < ActiveRecord::Migration[6.1]
  def change
    create_table :affiliations do |t|
      t.string :introduction
      t.references :user, null: false, foreign_key: true
      t.references :circle, null: false, foreign_key: true

      t.timestamps
    end
    add_index :affiliations, [:user_id, :circle_id], unique: true
  end
end
