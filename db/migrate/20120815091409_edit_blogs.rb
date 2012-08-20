class EditBlogs < ActiveRecord::Migration
  def up
  	add_column :blogs, :user_id, :integer, :default => 0
  end

  def down
  	remove_column :blogs, :user_id
  end
end
