class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
    	t.string   "name",               :limit => 30, :null => false
	    t.string   "description",        :limit => 200
	    t.string   "attachment",         :null => false
	    t.string   "attachment_name"
	    t.integer  "attachment_size",    :default => 0
	    t.string   "attachment_content_type"
      t.timestamps
    end
  end
end
