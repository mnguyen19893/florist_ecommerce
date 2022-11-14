class Order < ApplicationRecord
  belongs_to :order_status
  belongs_to :user

  has_many :order_products
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true

  validates :gst, numericality: true
  validates :hst, numericality: true
  validates :pst, numericality: true
end
