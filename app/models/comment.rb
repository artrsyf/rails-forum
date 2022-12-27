class Comment < ApplicationRecord

  validates_presence_of :post_id, message: 'post_id - nil'
  validates_presence_of :user_id, message: 'user_id - nil'
  validates_presence_of :comment, message: 'Comment cant be empty'

  belongs_to :post
  belongs_to :user
end
