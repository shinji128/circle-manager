class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :place
      t.integer :event_fee
      t.datetime :event_at
      t.time :event_time
      t.integer :people_limit_num
      t.datetime :limit_answer_at
      t.text :note
      t.references :circle, null: false, foreign_key: true

      t.timestamps
    end
    add_index :events, :uuid, unique: true
  end
end
