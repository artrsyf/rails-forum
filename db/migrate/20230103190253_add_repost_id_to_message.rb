class AddRepostIdToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :repost_id, :integer
  end
end
