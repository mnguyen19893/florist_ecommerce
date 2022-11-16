class Product < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :high, resize_to_limit: [800, 400]
    attachable.variant :normal, resize_to_limit: [400, 200]
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end

  belongs_to :category

  has_many :order_products
  has_many :orders, through: :order_products

  validates :name, presence: true
  validates :description_url, presence: true
  validates :sale, numericality: true, inclusion: 0..1, allow_blank: true
  validates :price, numericality: true
end
