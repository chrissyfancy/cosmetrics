class ProfilePhotoUploader < CarrierWave::Uploader::Base
  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
