class Album < ActiveRecord::Base
  attr_accessible :name, :description, :permission_cd, :password

  # Associations
  has_many :logs, :as => :recordable, :order => "created_at DESC"
  has_many :photos

  # enums
  as_enum :permission, { :public => 0, :private => 1, :password => 2 }

  # Validates
  validates :name, :permission_cd, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :permission_cd? do |permission_cd|
  	permission_cd.validates :permission_cd, :numericality => { :only_integer => true }
  end

  # scopes
  scope :created_desc, order("created_at DESC")

  # Callbacks
  before_save :create_or_update_log
  before_destroy :destroy_log

  # Methods
  def self.logs(action = nil, limit = nil)
    result = Log.with_model(self.model_name).created_desc
    if action != :all || action.blank?
      result = result.with_action(action)
    end
    if !limit.blank?
      result = result.limit(limit)
    end
    result
  end

  def create_or_update_log
    action = self.new_record? ? "create" : "update"
    self.logs.build(:action => action, :message => self.name)
  end

  def destroy_log
    self.logs.create(:action => "destroy", :message => self.name)
  end

end
