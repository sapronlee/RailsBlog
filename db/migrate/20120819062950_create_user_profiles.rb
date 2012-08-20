class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
    	t.references :user
    	t.string		 :real_name,  :limit => 20
    	t.string		 :phone,			:limit => 11
    	t.date			 :birthday
    	t.integer		 :gender_cd,		:default => 0
    	t.integer		 :title_cd,			:default => 0		 
      t.timestamps
    end
  end
end
