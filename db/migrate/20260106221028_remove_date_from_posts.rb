class RemoveDateFromPosts < ActiveRecord::Migration[8.1]
  def change
    remove_column :posts, :date, :date
  end
end
