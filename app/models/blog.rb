class Blog < ActiveRecord::Base
  attr_accessible :title, :body, :keywords, :description, :category_id

  # Associations
  has_many :logs, :as => :recordable, :order => "created_at DESC"
  belongs_to :category, :counter_cache => true

  # Callbacks
  before_save :create_or_update_log
  before_destroy :destroy_log

  # Validates
  validates :title, :body, :category_id, :presence => true
  with_options :if => :title? do |title|
    title.validates :title, :length => { :within => 2..100 }
    title.validates :title, :uniqueness => true
  end
  with_options :if => :keywords? do |keywords|
  	keywords.validates :keywords, :length => { :within => 1..100 }
  end
  with_options :if => :description? do |description|
  	description.validates :description, :length => { :within => 1..100 }
  end

  # scopes
  scope :created_desc, order("created_at DESC")
  scope :search_name, lambda { |name| where("ucase(`Blogs`.`title`) like concat('%',ucase(?),'%')", name) }

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
    self.logs.build(:action => action, :message => self.title)
  end

  def destroy_log
    self.logs.create(:action => "destroy", :message => self.title)
  end

end
