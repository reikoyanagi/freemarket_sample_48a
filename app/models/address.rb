class Address < ApplicationRecord

  validates :phone_number, presence: true,uniqueness: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :block, presence: true


  belongs_to :user, optional: true
end
