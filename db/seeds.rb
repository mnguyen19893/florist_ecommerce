require 'csv'
require 'faker'

# to delete all ActiveStorage in database and in local storage
# rails c
# ActiveStorage::Attachment.all.each { |attachment| attachment.purge }

AdminUser.destroy_all
Address.delete_all
Province.delete_all

OrderProduct.delete_all
Product.delete_all
Category.delete_all
Order.delete_all
OrderStatus.delete_all
User.delete_all
Contact.delete_all
About.delete_all

########################################################################################################################
# Provinces and Taxes
# https://www.retailcouncil.org/resources/quick-facts/sales-tax-rates-by-province/https://www.retailcouncil.org/resources/quick-facts/sales-tax-rates-by-province/
#######################################################################################################################
Province.create(name: 'Alberta',                  pst: 0,    gst: 0.05, hst: 0)
Province.create(name: 'British Columbia',         pst: 0.07, gst: 0.05, hst: 0)
mb = Province.create(name: 'Manitoba',            pst: 0.07, gst: 0.05, hst: 0)
Province.create(name: 'New Brunswick',            pst: 0,    gst: 0,    hst: 0.15)
Province.create(name: 'Newfoundland and Labrador',pst: 0,    gst: 0,    hst: 0.15)
Province.create(name: 'Northwest Territories',    pst: 0,    gst: 0.05, hst: 0)
Province.create(name: 'Nova Scotia',              pst: 0,    gst: 0,    hst: 0.15)
Province.create(name: 'Nuvavut',                  pst: 0,    gst: 0.05, hst: 0)
Province.create(name: 'Ontario',                  pst: 0,    gst: 0,    hst: 0.13)
Province.create(name: 'Prince Edward Island',     pst: 0,    gst: 0,    hst: 0.15)
Province.create(name: 'Quebec',                   pst: 0.09975,gst: 0.05, hst: 0)
Province.create(name: 'Saskatchewan',             pst: 0.06,  gst: 0.05, hst: 0)
Province.create(name: 'Yukon',                    pst: 0,     gst: 0.05, hst: 0)

########################################################################################################################
# Create a user and an address
########################################################################################################################
user = User.create(
  email: 'uhoang19893@gmail.com',
  password: '123456',
  password_confirmation: '123456'
)

address = Address.create(
  number: '7',
  street: 'Lyndhurst',
  city: 'Steinbach',
  postal_code: 'R5G0S5',
  province_id: mb.id,
  user_id: user.id
)

########################################################################################################################
# Order Status
########################################################################################################################
OrderStatus.create(name: 'new')
OrderStatus.create(name: 'paid')
OrderStatus.create(name: 'shipped')

########################################################################################################################
# About and Contact
#######################################################################################################################
About.create(title: 'Floral E-commerce', content: 'We sell flowers online. Check it out')
Contact.create(title: 'If you have any question, please contact ', content: 'floral@rrc.ca')

########################################################################################################################
# Admin user
########################################################################################################################
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end


########################################################################################################################
# Create products and categories
########################################################################################################################
csv_file = Rails.root.join('db/Flower_Table.csv')
csv_data = File.read(csv_file)
flowers = CSV.parse(csv_data, headers: true)

i = 0
max_products = 10
flowers.each do |flower|
  # if i < 50
  #   i += 1
  # else
    category = Category.find_or_create_by(name: flower['Flower_group'])
    if category && category.valid?
      f = category.products.create(
        name: flower['Flower name'],
        description_url: flower['url'],
        containers: flower['Containers'],
        flower_time: flower['Flower Time'],
        price: Faker::Commerce.price(range: 5.00..200.00)
      )
      puts "Creating flower ##{i} #{f.name}"
      query = URI.encode_www_form_component([f.name + ' flower'])
      downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
      f.image.attach(io: downloaded_image, filename: "m-#{f.name}.jpg")
      sleep(1)

      i += 1
      break if i == max_products
    # end
  end
end
puts "Number of categories created: #{Category.count}"
puts "Number of products created: #{Product.count}"
