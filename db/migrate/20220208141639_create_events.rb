class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
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
  end
end
