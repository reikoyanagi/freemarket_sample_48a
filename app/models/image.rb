class Image < ApplicationRecord
  validates :item_image, presence: true

  mount_uploader :item_image, ItemImageUploader
  belongs_to :item
end
