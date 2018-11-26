class AttachmentUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.element_type}/#{model.element.id}/files/#{model.id}"
  end

end
