#encoding : utf-8
class Category < ActiveRecord::Base
  attr_accessible :name, :url, :order

  # Associations
  has_many :blogs, :order => "created_at DESC"
  has_many :logs, :as => :recordable, :order => "created_at DESC"

  # Callbacks
  before_save :create_or_update_log
  before_destroy :destroy_log

  # Validates
  validates :name, :url, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..20 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :url? do |url|
  	url.validates :url, :uniqueness => true
  	url.validates :url, :format => { :with => /^[A-Za-z0-9\s]+$/, :message => "只能是A-Z，0-9和空格字符组成。" }
  	url.validates :url, :length => { :within => 2..50 }
  end
  with_options :if => :order? do |order|
  	order.validates :order, 
  									:numericality => { 
  										:only_integer => true, 
  										:greater_than_or_equal_to => 0, 
  										:less_than_or_equal_to => 999 }
  end

  # friendly_id gem setttings
  include FriendlyId
  friendly_id :url, :use => [:slugged]

  # Scopes
  scope :search_name, lambda { |name| where("ucase(`Categories`.`name`) like concat('%',ucase(?),'%')", name) }

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
