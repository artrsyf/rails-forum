require 'rails_helper'

RSpec.describe Repost, type: :model do
  before do
    User.delete_all
    Post.delete_all
    test_user = User.new(email: 'example1@example.com', password: 'example1', name: 'example1')
    test_user.skip_confirmation!
    test_user.save
    post_title = 'example1example1example1example1example1example1'
    post_content = 'content1content1content1content1content1content1content1content1content1content1connt1content1content
                    1content1content1'
    Post.create(user_id: test_user.id, title: post_title, content: post_content)
    test_profile = Profile.new(user_id: test_user.id, nick_name: test_user.name)
    test_profile.save
  end

  describe 'correct repost creating' do
    it 'should correct create repost and pass validations' do
      repost = Repost.new(repost_id: Post.first.id, profile_id: Profile.first.id)
      repost.valid?
      repost.save
      expect(repost.errors.first).to eq(nil)
    end
  end

  describe 'incorrect repost creating when repost_id nil' do
    it 'should fail validations and drop fail message' do
      repost = Repost.new(profile_id: Profile.first.id)
      repost.valid?
      repost.save
      expect(repost.errors.first.type).to eq(:blank)
      expect(repost.errors.first.attribute).to eq(:repost_id)
    end
  end

  describe 'incorrect repost creating when profile_id nil' do
    it 'should fail validations and drop fail message' do
      repost = Repost.new(repost_id: Post.first.id)
      repost.valid?
      repost.save
      expect(repost.errors.first.type).to eq(:blank)
      expect(repost.errors.first.attribute).to eq(:profile_id)
    end
  end
end
