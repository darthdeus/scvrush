# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  version :normal do
    process :resize_to_fit => [840, 540]
  end
  
  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
