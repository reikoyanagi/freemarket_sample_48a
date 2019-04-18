class Item < ApplicationRecord
  accepts_nested_attributes_for :images
  has_many :images, dependent: :destroy
end
