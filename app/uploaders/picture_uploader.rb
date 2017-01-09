class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [100, 100]
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url *args
    ActionController::Base.helpers.asset_path("fallback/" +
      [version_name, "default.jpg"].compact.join('_'))
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
