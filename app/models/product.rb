class Product < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :normal, resize_to_limit: [100, 100]
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  belongs_to :category

  has_many :order_products
  has_many :orders, through: :order_products

  validates :name, presence: true
  validates :description_url, presence: true
  validates :sale, numericality: true, inclusion: 0..1
  validates :price, numericality: true
end
