require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'Henok Mekonnen', photo: 'https://shorturl.at/nrsOQ', bio: 'Developer from Ethiopia.')
    @post = Post.create(author: @user, title: 'My first post', text: 'This is my first post')
  end

  describe 'Validations' do
    it 'should validate the presence of name' do
      expect(@user).to validate_presence_of(:name)
    end

    it 'should validate that posts_counter is an integer and greater than or equal to 0' do
      expect(@user).to validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0)
    end
  end

  describe 'Associations' do
    it 'should have many posts' do
      expect(@user).to have_many(:posts).with_foreign_key('author_id').dependent(:destroy)
    end

    it 'should have many comments' do
      expect(@user).to have_many(:comments).dependent(:destroy)
    end

    it 'should have many likes' do
      expect(@user).to have_many(:likes).dependent(:destroy)
    end
  end

  describe 'Callbacks' do
    it 'should update posts_counter after create' do
      user = User.create(name: 'John Doe', photo: 'https://example.com', bio: 'Bio here')
      Post.create(author: user, title: 'My Post', text: 'Post content')
      expect(@user.posts_counter).to eq(nil)
    end

    it 'should update posts_counter after destroy' do
      @post.destroy
      @user.reload
      expect(@user.posts_counter).to eq(0)
    end
  end

  describe 'Methods' do
    it 'should return recent posts' do
      recent_posts = @user.post_recent
      expect(recent_posts).to be_an(ActiveRecord::Relation)
    end
  end
end
