class Product < ActiveRecord::Base
  has_many :product_images
  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :product_images, :allow_destroy => true
end
