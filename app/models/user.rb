class User < ApplicationRecord
  after_create :add_address

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  has_many :orders
  accepts_nested_attributes_for :orders

  def add_address
    #puts "Hoang add an address"
    Address.create(
      number: '',
      street: '',
      city: '',
      postal_code: '',
      province_id: Province.first.id,
      user_id: id
    )
    # unless address.valid?
    #   puts "address: #{address}"
    #   puts address.errors.messages
    # end
  end
end
