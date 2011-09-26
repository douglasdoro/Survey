# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

#  process :resize_to_fill => [200, 200]

  version :thumb do
     process :resize_to_limit => [100, 100]
  end

  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end
  
end
