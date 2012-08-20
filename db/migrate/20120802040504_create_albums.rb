class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
    	t.string	:name,				  :limit => 30, :null => false
    	t.integer	:permission_cd,	:limit => 1,	:null => false
    	t.string	:description,	  :limit => 200
    	t.string	:password,      :limit => 100
      t.integer :photos_count,  :default => 0
      t.integer :cover,         :default => 0
      t.integer :is_default,    :default => 0
      t.timestamps
    end
    add_index :albums, :name, unique: true
  end
end
