class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
    	t.references :recordable, 	:polymorphic => true
    	t.string 		 :action,  	    :null => :false, :limit => 50
			t.string		 :message, 	    :limit => 500
      t.timestamps
    end
  end
end
