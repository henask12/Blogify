class User < ApplicationRecord
 # devise :database_authenticatable, :registerable, :confirmable,
 # :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :user_id
  has_many :likes, foreign_key: :user_id

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  # New fields
  attr_accessor :email, :encrypted_password, :reset_password_token,
                :reset_password_sent_at, :remember_created_at,
                :confirmation_token, :confirmed_at, :confirmation_sent_at,
                :unconfirmed_email

  # Returns the 3 most recent posts
  def post_recent
    posts.order(created_at: :desc).limit(3)
  end
end
