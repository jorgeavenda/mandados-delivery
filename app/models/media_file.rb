class MediaFile < ActiveRecord::Base
  def get_image_original
    self.media.present? ? self.media.url(:original) : "/assets/default.png"
  end  
  validates :media,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }

  has_attached_file :media, styles: {
  }
end
