class AddTimestampsToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :updated_at, :datetime
    add_column :likes, :created_at, :datetime
  end
end
