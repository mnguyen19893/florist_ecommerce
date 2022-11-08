class Province < ApplicationRecord
  has_many :address

  validates :name, presence: true
  validates :gst, numericality: true
  validates :hst, numericality: true
  validates :pst, numericality: true
end
