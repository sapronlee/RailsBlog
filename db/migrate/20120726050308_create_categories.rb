class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.string			:name,					:null => false, :limit => 100
      t.string      :url,           :null => false, :limit => 50
    	t.string			:slug,					:null => false, :limit => 100
    	t.integer			:order,					:default => 0
    	t.integer			:posts_count,		:default => 0		
      t.timestamps
    end

    add_index :categories, :name, unique: true
	  add_index :categories, :url,  unique: true
	  add_index :categories, :slug, unique: true
  end
end
