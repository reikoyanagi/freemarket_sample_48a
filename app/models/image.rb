class Image < ApplicationRecord
  mount_uploader :item_image, ItemImageUploader
  belongs_to :item
end
