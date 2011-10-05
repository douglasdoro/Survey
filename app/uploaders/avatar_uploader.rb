# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
 
  process :resize_to_fill => [400, 400]

  version :thumb do
     process :resize_to_limit => [140, 140]
  end
  
  version :mini do
     process :resize_to_limit => [40, 40]
  end

  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end
  
end
