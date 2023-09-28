class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.create_like(user, post)
    Like.create(user: user, post: post)
  end

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
