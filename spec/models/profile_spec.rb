require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    User.delete_all
    #Profile.delete_all
    test_user = User.create(email: 'example1@example.com', password: 'example1', name: 'example1')
  end

  describe 'creating profile according to all validations' do
    it 'should create profile and pass all validations' do
      profile = Profile.new(user_id: User.first.id, nick_name: User.first.name)
      profile.valid?
      profile.save
      expect(profile.errors.first).to eq(nil)
    end
  end

  describe 'incorrect creating profile when user_ud nil' do
    it 'should fail validations and drop fail message' do
      profile = Profile.new(nick_name: User.first.name)
      profile.valid?
      expect(profile.errors.first.type).to eq(:blank)
      expect(profile.errors.first.attribute).to eq(:user_id)
    end
  end

  describe 'incorrect creating profile when nick_name nil' do
    it 'should fail validations and drop fail message' do
      profile = Profile.new(user_id: User.first.id)
      profile.valid?
      expect(profile.errors.first.type).to eq(:blank)
      expect(profile.errors.first.attribute).to eq(:nick_name)
    end
  end

  describe 'incorrect creating profile when nick_name is incorrect' do
    it 'should fail validations and drop fail message' do
      profile = Profile.new(user_id: User.first.id, nick_name: '99999user999')
      profile.valid?
      expect(profile.errors.first.type).to eq(:invalid)
      expect(profile.errors.first.attribute).to eq(:nick_name)
    end
  end

  describe 'incorrect creating profile when profile when input user_id already exists' do
    it 'should fail validations and drop fail message' do
      Profile.create(user_id: User.first.id, nick_name: 'qwerty111')
      profile = Profile.new(user_id: User.first.id, nick_name: 'qwerty111')
      profile.valid?
      expect(profile.errors.first.type).to eq(:taken)
      expect(profile.errors.first.attribute).to eq(:user_id)
    end
  end
end
