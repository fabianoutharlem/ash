# encoding: utf-8

class SettingImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick

  include CarrierWave::MimeTypes

  # Choose what kind of storage to use for this uploader:
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb, if: :image? do
    process resize_to_fit: [200, 150]
  end

  process :set_content_type

  protected

  def image?(new_file)
    new_file.content_type.include? 'image'
  end
end
