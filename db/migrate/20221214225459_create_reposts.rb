class CreateReposts < ActiveRecord::Migration[7.0]
  def change
    create_table :reposts do |t|
      t.integer :repost_id
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
