class Log < ActiveRecord::Base
	attr_accessible :action, :message

  belongs_to :recordable, :polymorphic => true

  # scopes
  scope :with_model, lambda { |model| where(:recordable_type => model) }
  scope :with_action, lambda { |action| where(:action => action) }
  scope :created_desc, order("created_at DESC")

end
