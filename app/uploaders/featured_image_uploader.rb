# encoding: utf-8
class FeaturedImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end
  
  # TODO - add default URL
  
  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "https://s3.amazonaws.com/scvrush/uploads/post/featured_image/thumb_100x100_dark.png"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
