# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(name: 'Henok Mekonnen', photo: 'https://shorturl.at/nrsOQ', bio: 'Developer from Ethiopia.')
    @post = Post.create(author: @user, title: 'My first post', text: 'This is my first post')
  end

  describe 'Validations' do
    it 'should validate the presence of title' do
      expect(@post).to validate_presence_of(:title)
    end

    it 'should validate the maximum length of title' do
      expect(@post).to validate_length_of(:title).is_at_most(250)
    end

    it 'should validate that comments_counter is an integer and greater than or equal to 0' do
      expect(@post).to validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0)
    end

    it 'should validate that likes_counter is an integer and greater than or equal to 0' do
      expect(@post).to validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0)
    end
  end

  describe 'Associations' do
    it 'should belong to an author (User)' do
      expect(@post).to belong_to(:author).class_name('User').with_foreign_key('author_id')
    end

    it 'should have many comments' do
      expect(@post).to have_many(:comments).dependent(:destroy)
    end

    it 'should have many likes' do
      expect(@post).to have_many(:likes).dependent(:destroy)
    end
  end

  describe 'Methods' do
    it 'should return recent comments' do
      recent_comments = @post.recent_comments(5)
      expect(recent_comments).to be_an(ActiveRecord::Relation)
    end
  end
end
