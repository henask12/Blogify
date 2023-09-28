class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_user_posts_counter
  after_destroy :update_user_posts_counter

  def update_user_posts_counter
    update(posts_counter: posts.count)
  end
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
