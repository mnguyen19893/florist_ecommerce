class User < ApplicationRecord
  after_create :add_address

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  has_many :orders

  def add_address
    Address.create(
      number: '',
      street: '',
      city: '',
      postal_code: '',
      province_id: Province.first.id,
      user_id: id
    )
  end
end
