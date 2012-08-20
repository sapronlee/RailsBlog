class UserProfile < ActiveRecord::Base
  attr_accessible :real_name, :phone, :birthday, :gender_cd, :title_cd

	# Associations
  belongs_to :user

  # enums
  as_enum :gender, { :secret => 0, :female => 1, :male => 2 }
end
