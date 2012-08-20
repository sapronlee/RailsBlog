class EditCategories < ActiveRecord::Migration
  def up
  	rename_column :categories, :posts_count, :blogs_count
  end

  def down
  	rename_column :categories, :blogs_count, :posts_count
  end
end
