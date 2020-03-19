class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process :resize_to_limit => [200, 200]
  process :convert => 'jpg'
  version :thumb do
   process resize_to_fit: [200, 200]
  end
  version :thumb50 do
    process resize_to_fit: [100, 100]
  end
  storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
