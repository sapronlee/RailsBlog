class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :profile_attributes
  attr_accessor :login

  # Associations
  has_one :profile, :class_name => "UserProfile", :dependent => :destroy
  accepts_nested_attributes_for :profile

  # Callbacks
  before_save :add_profile


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def add_profile
    if self.profile.blank?
      self.build_profile :gender_cd => 0, :title_cd => 0
    end
  end

end
