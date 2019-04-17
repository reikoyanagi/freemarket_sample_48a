class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  has_one :delivery, dependent: :destroy
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :delivery
end
