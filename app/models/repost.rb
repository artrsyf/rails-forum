class Repost < ApplicationRecord

  validates_presence_of :profile_id, message: 'profile_id - nil'
  validates_presence_of :repost_id, message: 'repost_id - nil'
  validates :recipients_count, comparison: { other_than: 0, message: 'Choose any recipient' }, if: :is_message_repost?
  validates_presence_of :location, message: 'You should choose repost location'
  belongs_to :profile

  def recipients_count
    recipients.scan(/\d+/).map(&:to_i).each.map { |array_element| array_element }.length
  end

  def is_message_repost?
    location == 'message_repost'
  end
end
