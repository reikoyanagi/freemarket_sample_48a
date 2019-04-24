class Item < ApplicationRecord
  validates :name, :condition, :price, :detail, presence: true

  has_many :images, dependent: :destroy
  has_one :delivery, dependent: :destroy
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :delivery

  belongs_to :user
    # 購入機能
  has_many :transactions, dependent: :destroy

end
