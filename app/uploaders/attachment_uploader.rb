# encoding: utf-8
class AttachmentUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :file

  def store_dir
    "#{base_store_dir}/#{model.id}"
  end

  def base_store_dir
    "uploads/#{model.class.to_s.pluralize}/#{model.read_attribute(:attachment)[0, 2]}"
  end

  def default_url
    asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  process :set_content_type


  def extension_white_list
    %w(mp4 mp3)
  end

  def filename
    @name ||= "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path)
    
    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path)
  rescue SystemCallError
    true
  end

end
