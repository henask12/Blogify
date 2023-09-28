class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end

  def recent_comments(limit = 5)
    post.comments.order(created_at: :desc).limit(limit)
  end
end
