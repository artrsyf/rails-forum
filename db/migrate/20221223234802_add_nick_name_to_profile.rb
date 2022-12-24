class AddNickNameToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :nick_name, :string
  end
end
