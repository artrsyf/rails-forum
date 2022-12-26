class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.boolean :is_private, default: false
      t.json :room_users

      t.timestamps
    end
  end
end
