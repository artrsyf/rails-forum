require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    User.delete_all
    Room.delete_all
    test_user = User.new(email: 'example1@example.com', password: 'example1', name: 'example1')
    test_user.skip_confirmation!
    test_user.save
    test_room = Room.new(name: 'test_room')
    test_room.save
    test_profile = Profile.new(user_id: test_user.id, nick_name: test_user.name)
    test_profile.save
  end

  describe 'correct creating message' do
    it 'should pass validations and create message' do
      message = Message.new(user_id: 1, room_id: 1, body: 'Some message')
      message.valid?
      message.save
      expect(message.errors.first).to eq(nil)
    end
  end

  describe 'incorrect when user_id is nil' do
    it 'should fail validations and drop fail message' do
      message = Message.new(room_id: 1, body: 'Some message')
      message.valid?
      expect(message.errors.first.attribute).to eq(:user_id)
      expect(message.errors.first.type).to eq(:blank)
    end
  end

  describe 'incorrect when room_id is nil' do
    it 'should fail validations and drop fail message' do
      message = Message.new(user_id: 1, body: 'Some message')
      message.valid?
      expect(message.errors.first.attribute).to eq(:room_id)
      expect(message.errors.first.type).to eq(:blank)
    end
  end

  describe 'incorrect when message content is nil' do
    it 'should fail validations and drop fail message' do
      message = Message.new(user_id: 1, room_id: 1)
      message.valid?
      expect(message.errors.first.attribute).to eq(:body)
      expect(message.errors.first.type).to eq(:blank)
    end
  end
end
