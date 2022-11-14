Rails.configuration.stripe = {
  publishable_key: ENV['PUBLISHABLE_KEY'],
  secret_key: ENV['SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]

# PUBLISHABLE_KEY=pk_test_dRZYftRVo14McnY92qnOULZB SECRET_KEY=sk_test_Dj9eOiS1VMGiiqWLVQduopgD rails s