class AddRecipientsToReposts < ActiveRecord::Migration[7.0]
  def change
    add_column :reposts, :recipients, :string, default: nil
  end
end
