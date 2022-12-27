require 'json'

class Room < ApplicationRecord
  validates_uniqueness_of :room_users
  validates_presence_of :name, message: 'name - nil'
  validates :room_users, presence: true, if: :is_json?
  validates :json_records_count, comparison: { equal_to: 2 }, if: :is_json?
  validates :room_users, comparison: { other_than: :reverse_json }, if: :is_json?
  validates :name, comparison: { equal_to: "dual_room" }, if: :is_json?

  scope :public_rooms, -> { where(is_private: false) }
  has_many :messages
  after_create_commit {broadcast_append_to "rooms"}

  

  def is_room_dual?
    !room_users.nil?
  end

  def json_records_count
    if is_json?
      JSON.parse(room_users).length
    else
      raise 'Error. Room model, got not json'
    end
  end

  def is_json?
    begin
      !!JSON.parse(room_users)
    rescue
      false
    end
  end

  def reverse_json
    reverse = { user1: JSON.parse(room_users)['user2'], user2: JSON.parse(room_users)['user1'] }.to_json
    room_users if Room.find_by(room_users: reverse) 
  end
end
