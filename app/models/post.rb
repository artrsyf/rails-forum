class Post < ApplicationRecord
  validates_presence_of :user_id, message: 'user_id - nil'
  validates_presence_of :title, message: 'Title cant be empty'
  validates :title, length: {minimum: 20, message: 'Title is very short'}
  validates_presence_of :content, message: 'Content cant be empty'
  validates :content, length: {minimum: 60, message: 'Content is very short'}

  belongs_to :user
  has_many :comments
  acts_as_votable
  has_one_attached :avatar
end
