class Room < ApplicationRecord
    validates_uniqueness_of :room_users
    scope :public_rooms, -> { where(is_private: false) }
    has_many :messages
    after_create_commit {broadcast_append_to "rooms"}
end
