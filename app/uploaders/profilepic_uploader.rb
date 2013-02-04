class ProfilepicUploader < CarrierWave::Uploader::Base 

  # Choose what kind of storage to use for this uploader:
  storage :fog
  include CarrierWave::MimeTypes
  process :set_content_type
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
end
