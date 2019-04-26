class Image < ApplicationRecord
  validates :item_image, presence: true
  # 複数にするときは mount_uploaders にして serialize を表示
  serialize :item_image, JSON
  mount_uploaders :item_image, ItemImageUploader
  belongs_to :item, optional: true


end
