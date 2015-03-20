class ResumeFileUploader < CarrierWave::Uploader::Base

  storage :fog

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def extension_white_list
    %w(doc docx pdf txt)
  end

end
