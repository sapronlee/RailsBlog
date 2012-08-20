require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'carrierwave/processing/mini_magick'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module RailsBlog
  class Application < Rails::Application
    config.time_zone = 'Chongqing'
    
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :zh_CN
    
    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.active_support.escape_html_entities_in_json = true

    config.active_record.whitelist_attributes = true

    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end
