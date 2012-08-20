class Photo < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :name, :description, :image, :album_id

  # Associations
  has_many :logs, :as => :recordable, :order => "created_at DESC"
  belongs_to :album, :counter_cache => true

  # Callbacks
  before_save :update_image_attributes, :create_or_update_log
  before_destroy :destroy_log

  # carrierwave
  mount_uploader :image, ImageUploader

  # Validates
  validates :album_id, :image, :presence => true
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
    if image.present? && image_changed?
      self.name = image.file.basename
      self.image_size = image.file.size
      self.image_content_type = image.file.content_type
    end
  end

  def create_or_update_log
    action = self.new_record? ? "create" : "update"
    self.logs.build(:action => action, :message => self.name)
  end

  def destroy_log
    self.logs.create(:action => "destroy", :message => self.name)
  end

  def to_jq_upload
    {
      "id" => read_attribute(:id),
      "name" => read_attribute(:name),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => admin_photo_path(:id => id),
      "delete_type" => "DELETE" 
    }
  end

end
