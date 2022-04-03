class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.integer :user_a
      t.integer :user_b
      t.integer :user_c
      t.integer :user_d
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
