class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  version :medium_avatar do
    process resize_to_fill: [125, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
