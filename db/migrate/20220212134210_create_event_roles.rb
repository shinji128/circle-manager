class CreateEventRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :event_roles do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
