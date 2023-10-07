class AddBlogIdToShops < ActiveRecord::Migration[7.0]
  def change
    add_column :shops, :blog_id, :string
  end
end
