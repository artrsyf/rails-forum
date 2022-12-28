class Profile < ApplicationRecord

  validates_presence_of :user_id, message: 'user_id - nil'
  validates_uniqueness_of :user_id, message: 'This user_id already exist'
  validates_presence_of :nick_name, message: 'Nick_name cant be nil'
  validates :nick_name, format: {with: /\A[a-z]{4,10}[_]{0,1}[0-9]{0,4}\z/, message: 'Your nick_name is incorrect' }

  has_many :reposts
  has_one_attached :avatar
end
