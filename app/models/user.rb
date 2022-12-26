class User < ApplicationRecord
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
      updated_at
    end
  end
end
