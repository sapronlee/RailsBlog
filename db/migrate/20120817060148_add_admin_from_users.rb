class AddAdminFromUsers < ActiveRecord::Migration
  def change
  	add_column :users, :admin, :boolean, :defaults => false
  end
end
