class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :number, presence: true
  validates :street, presence: true
  validates :city, presence: true
  CANADIAN_POSTAL_CODE_FORMAT = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1}[ -]?\d{1}[A-Z]{1}\d{1}\z/
  validates :postal_code, format: { with: CANADIAN_POSTAL_CODE_FORMAT }

end
