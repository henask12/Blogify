require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @user = User.create(name: 'César Herrera', photo: 'https://i.pravatar.cc/150?img=3', bio: 'I am a developer')
    @post1 = Post.create(author_id: @user.id, title: 'My first post', text: 'This is my first post')
    @post2 = Post.create(author_id: @user.id, title: 'My second post', text: 'This is my second post')
  end

  # I can see the username of all other users.
  scenario 'shows the username of all other users' do
    visit users_path
    expect(page).to have_content('César Herrera')
    expect(page).to have_content('Number of post: 2')
    expect(page).to have_content('Add a new post')
  end

  # I can see the profile picture for each user.
  scenario 'shows the profile picture for each user' do
    visit users_path
    expect(page).to have_css("img[src*='https://i.pravatar.cc/150?img=3']")
  end

  # I can see the number of posts each user has written.
  scenario 'shows the number of posts each user has written' do
    visit users_path
    expect(page).to have_content('Number of post: 2')
  end
end
