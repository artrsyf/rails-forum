class AddLocationToReposts < ActiveRecord::Migration[7.0]
  def change
    add_column :reposts, :location, :string
  end
end
