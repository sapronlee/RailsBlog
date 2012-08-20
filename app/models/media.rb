class Media < ActiveRecord::Base
  attr_accessible :name, :description, :attachment

  # Associations
  has_many :logs, :as => :recordable, :order => "created_at DESC"

  # Callbacks
  before_save :update_image_attributes, :create_or_update_log
  before_destroy :destroy_log

  # carrierwave
  mount_uploader :attachment, AttachmentUploader

  # Validates
  validates :attachment, :name, :presence => true
  with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
  end

  # scopes
  scope :created_desc, order("created_at DESC")

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
  
  def update_image_attributes
    if attachment.present? && attachment_changed?
      self.name = attachment.file.basename
      self.attachment_size = attachment.file.size
      self.attachment_content_type = attachment.file.content_type
    end
  end

  def create_or_update_log
    action = self.new_record? ? "create" : "update"
    self.logs.build(:action => action, :message => self.name)
  end

  def destroy_log
    self.logs.create(:action => "destroy", :message => self.name)
  end
end
