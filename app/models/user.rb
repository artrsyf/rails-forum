class User < ApplicationRecord

  validates_presence_of :name, message: 'Name cant be empty'
  validates :name, length: { minimum: 4, message: 'Name is very short' }
  validates :name, format: { with: /\A[a-z]{4,10}[_]{0,1}[0-9]{0,4}\z/, message: 'Your name is incorrect' }
  validates_uniqueness_of :name, message: 'This name already exist'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable
  has_many :posts
  has_many :comments
  acts_as_voter
  scope :all_except, -> (user) { where.not(id: user) }
  has_many :messages

  def online?
    if updated_at > 10.minutes.ago
      'online'
    else
      updated_at + 3 * 60 * 60
    end
  end
end
