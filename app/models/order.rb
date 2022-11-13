class Order < ApplicationRecord
  belongs_to :order_status
  belongs_to :user

  has_many :order_products
  has_many :products, through: :order_products

  validates :gst, numericality: true
  validates :hst, numericality: true
  validates :pst, numericality: true
end
