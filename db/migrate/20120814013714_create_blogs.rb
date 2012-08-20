class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
    	t.references :category
    	t.string		 :title,				:null => false, :limit => 200
    	t.string		 :keywords,			:limit => 100
    	t.string		 :description, 	:limit => 100
    	t.text			 :body,					:null => false
      t.timestamps
    end
  end
end
