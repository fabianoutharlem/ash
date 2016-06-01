# encoding: utf-8
require 'carrierwave/processing/mime_types'

class CarMediaUploader < CarrierWave::Uploader::Base

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

  version :large, if: :image? do
    process resize_to_fill: [1024, 768]
  end

  version :thumb, if: :image?, from_version: :large do
    process resize_to_fill: [400, 300]
  end

  process :set_content_type

  protected

  def image?(new_file)
    new_file.content_type.include? 'image'
  end

end
