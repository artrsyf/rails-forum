# class DropProfiles < ActiveRecord::Migration[7.0]
#   def change
#     drop_table :profiles, if_exists: true do |t|
#       t.integer "user_identifier"
#       t.timestamps null: false
#     end
#   end
# end
