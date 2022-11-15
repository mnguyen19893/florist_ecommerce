class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :number, presence: true, allow_blank: true
  validates :street, presence: true, allow_blank: true
  validates :city, presence: true, allow_blank: true
  CANADIAN_POSTAL_CODE_FORMAT = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1}[ -]?\d{1}[A-Z]{1}\d{1}\z/
  validates :postal_code, format: { with: CANADIAN_POSTAL_CODE_FORMAT }, allow_blank: true

end
