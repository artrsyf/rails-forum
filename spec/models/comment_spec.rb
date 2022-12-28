require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    User.delete_all
    Post.delete_all
    test_user = User.new(email: 'example1@example.com', password: 'example1', name: 'example1')
    test_user.skip_confirmation!
    test_user.save
    post_title = 'example1example1example1example1example1example1'
    post_content = 'content1content1content1content1content1content1content1content1content1content1connt1content1content
                    1content1content1'
    Post.create(user_id: User.first.id, title: post_title, content: post_content)
  end

  describe 'creating comment according to all validations' do
    it 'should pass validation and create comment' do
      comment = Comment.new(post_id: Post.first.id, user_id: User.first.id, comment: 'comment1')
      comment.save
      expect(comment.errors.first).to eq(nil)
    end
  end

  describe 'creating comment with user_id == nil' do
    it 'should fail validation and drop error message' do
      comment = Comment.new(post_id: Post.first.id, comment: 'comment1')
      comment.valid?
      expect(comment.errors.first.attribute).to eq(:user_id)
      expect(comment.errors.first.type).to eq(:blank)
    end
  end

  describe 'creating comment with post_id == nil' do
    it 'should fail validation and drop error message' do
      comment = Comment.new(user_id: User.first.id, comment: 'comment1')
      comment.valid?
      expect(comment.errors.first.attribute).to eq(:post_id)
      expect(comment.errors.first.type).to eq(:blank)
    end
  end

  describe 'creating comment with comment_content == nil' do
    it 'should fail validation and drop error message' do
      comment = Comment.new(post_id: Post.first.id, user_id: User.first.id)
      comment.valid?
      expect(comment.errors.first.attribute).to eq(:comment)
      expect(comment.errors.first.type).to eq(:blank)
    end
  end
end
