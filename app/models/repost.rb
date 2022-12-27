class Repost < ApplicationRecord

  validates_presence_of :profile_id, message: 'profile_id - nil'
  validates_presence_of :repost_id, message: 'repost_id - nil'

  belongs_to :profile
end
