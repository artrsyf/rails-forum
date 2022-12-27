class Message < ApplicationRecord

  validates_presence_of :room_id, message: 'post_id - nil'
  validates_presence_of :user_id, message: 'user_id - nil'
  validates_presence_of :body, message: 'Your message cant be empty'

  belongs_to :user
  belongs_to :room
  after_create_commit { broadcast_append_to self.room }
end
