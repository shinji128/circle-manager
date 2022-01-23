class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uuid
      t.string :line_user_id, null: false, unique: true
      t.string :name

      t.timestamps
    end
  end
end
