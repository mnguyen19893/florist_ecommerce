Address.delete_all
Province.delete_all
User.delete_all

# Provinces and Taxes
# https://www.retailcouncil.org/resources/quick-facts/sales-tax-rates-by-province/https://www.retailcouncil.org/resources/quick-facts/sales-tax-rates-by-province/
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

# User and address
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


