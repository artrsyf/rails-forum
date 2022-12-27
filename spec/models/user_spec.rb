require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    User.delete_all
    Post.delete_all
  end

  describe 'correct registration' do
    it 'should pass validation and make new user' do
      test_user = User.new(email: 'example1@example.com', password: 'example1', name: 'example1')
      test_user.skip_confirmation!
      test_user.valid?
      test_user.save
      expect(test_user.errors.first).to eq(nil)
    end
  end

  describe 'incorrect registration when email is nil' do
    it 'should fail validation and drop fail message' do
      test_user = User.new(password: 'example1', name: 'example1')
      test_user.skip_confirmation!
      test_user.valid?
      expect(test_user.errors.first.attribute).to eq(:email)
      expect(test_user.errors.first.type).to eq(:blank)
    end
  end

  describe 'incorrect registration when email is incorrect' do
    it 'should fail validation and drop fail message' do
      test_user = User.new(email: 'example1examplecom', password: 'example1', name: 'example1')
      test_user.skip_confirmation!
      test_user.valid?
      expect(test_user.errors.first.attribute).to eq(:email)
      expect(test_user.errors.first.type).to eq(:invalid)
    end
  end

  describe 'incorrect registration when password is nil' do
    it 'should fail validation and drop fail message' do
      test_user = User.new(email: 'example1@example.com', name: 'example1')
      test_user.skip_confirmation!
      test_user.valid?
      expect(test_user.errors.first.attribute).to eq(:password)
      expect(test_user.errors.first.type).to eq(:blank)
    end
  end

  describe 'incorrect registration when name is nil' do
    it 'should fail validation and drop fail message' do
      test_user = User.new(email: 'example1examplecom', password: 'example1')
      test_user.skip_confirmation!
      test_user.valid?
      expect(test_user.errors.first.attribute).to eq(:name)
      expect(test_user.errors.first.type).to eq(:blank)
    end
  end
end
