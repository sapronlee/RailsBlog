class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.references 	:album
    	t.string 			:name, 					     :limit => 30, :null => false
    	t.string 			:description,	       :limit => 200
    	t.string			:image,		           :null => false
      t.string      :image_name
    	t.integer			:image_size,		     :default => 0
      t.string      :image_content_type
      t.timestamps
    end
  end
end
