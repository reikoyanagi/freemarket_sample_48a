class Delivery < ApplicationRecord
  validates :postage, :shipping, :region, :shipping_date, presence: true

  belongs_to :item
end
