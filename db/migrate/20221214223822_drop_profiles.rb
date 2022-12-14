class DropProfiles < ActiveRecord::Migration[7.0]
  def change
    drop_table :profiles do |t|
      t.integer "user_identifier"
      t.timestamps null: false
    end
  end
end
