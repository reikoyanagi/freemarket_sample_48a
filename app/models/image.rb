class Image < ApplicationRecord
  validates :item_image, presence: true
  mount_uploaders :item_image, ItemImageUploader
  serialize :item_image, JSON
  belongs_to :item, optional: true

end
