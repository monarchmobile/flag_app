class ImageUploader < CarrierWave::Uploader::Base
  # include CarrierWaveDirect::Uploader
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  # storage :file
 
  storage :fog
  include CarrierWave::MimeTypes
  process :set_content_type

  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process :crop
    resize_to_fit(800, 10000)
  end

  version :profile do
    process :crop
    resize_to_limit(200, 10000)
  end


  version :scrap do
    process :crop
    resize_to_fit(300, 300)
  end

  version :thumb do
    process :crop
    resize_to_limit(50, 50)
  end
  
  def crop
    if model.crop_x.present?
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop!(x, y, w, h)
      end
    end
  end

end
