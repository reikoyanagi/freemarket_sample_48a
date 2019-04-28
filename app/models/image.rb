class Image < ApplicationRecord
  validates :item_image, presence: true
  mount_uploader :item_image, ItemImageUploader
  belongs_to :item, optional: true

  def self.save_image(sent,item_id)
    cw_files = sent.require(:'0')[:item_image]
    cw_files.each do |img|
      image = Image.new(item_id: item_id, item_image: img)
      return false unless image.save!
    end
  end


end
