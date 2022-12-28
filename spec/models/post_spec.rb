require 'rails_helper'

RSpec.describe Post, type: :model do

  before do
    User.delete_all
    Post.delete_all
    test_user = User.new(email: 'example1@example.com', password: 'example1', name: 'example1')
    test_user.skip_confirmation!
    test_user.save
  end

  let(:post_title) { 'example1example1example1example1example1example1' }
  let(:post_content) { 'content1content1content1content1content1content1content1content1content1content1connt
                          1content1content1content1content1' }

  describe 'correct post creating' do
    it 'should successfully create post' do
      post = Post.new(user_id: User.first.id, title: post_title, content: post_content)
      post.avatar.attach(io: File.open("#{Rails.root}/local_storage/png_example.png"), filename: 'png_example.png', content_type: 'image/png')
      post.save
      expect(post.errors.first).to eq(nil)
    end
  end

  describe 'correct post creating when piicture is not attached' do
    it 'should successfully create post' do
      post = Post.new(user_id: User.first.id, title: post_title, content: post_content)
      post.valid?
      expect(post.errors.first).to eq(nil)
    end
  end

  describe 'correct post creating when user_id is nil' do
    it 'should fail validation and drop error message' do
      post = Post.new(title: post_title, content: post_content)
      post.valid?
      expect(post.errors.first.attribute).to eq(:user_id)
      expect(post.errors.first.type).to eq(:blank)
    end
  end

  describe 'correct post creating when post_title is nil' do
    it 'should fail validation and drop error message' do
      post = Post.new(user_id: User.first.id, content: post_content)
      post.valid?
      expect(post.errors.first.attribute).to eq(:title)
      expect(post.errors.first.type).to eq(:blank)
    end
  end

  describe 'correct post creating when post_content is nil' do
    it 'should fail validation and drop error message' do
      post = Post.new(user_id: User.first.id, title: post_title)
      post.valid?
      expect(post.errors.first.attribute).to eq(:content)
      expect(post.errors.first.type).to eq(:blank)
    end
  end

  describe 'creating post when title is short' do
    it 'should fail validation and drop error message' do
      post = Post.new(user_id: User.first.id, title: post_title[1..5], content: post_content)
      post.valid?
      expect(post.errors.first.attribute).to eq(:title)
      expect(post.errors.first.type).to eq(:too_short)
    end
  end

  describe 'creating post when content is short' do
    it 'should fail validation and drop error message' do
      post = Post.new(user_id: User.first.id, title: post_title, content: post_content[1..5])
      post.valid?
      expect(post.errors.first.attribute).to eq(:content)
      expect(post.errors.first.type).to eq(:too_short)
    end
  end
end
