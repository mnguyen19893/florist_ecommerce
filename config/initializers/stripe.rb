Rails.configuration.stripe = {
  publishable_key: ENV['PUBLISHABLE_KEY'],
  secret_key: ENV['SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]

# PUBLISHABLE_KEY=pk_test_dRZYftRVo14McnY92qnOULZB SECRET_KEY=sk_test_Dj9eOiS1VMGiiqWLVQduopgD rails s -b 0.0.0.0

# heroku run bash
# cat gcs.keyfile | gpg -ac -o- | curl -X PUT -T "-" https://transfer.sh/gsc.keyfile.gpg
# cat gcs.keyfile | gpg --armor --symmetric --output - | curl -X PUT --upload-file "-" https://transfer.sh/gcs.keyfile | pbcopy
# curl https://transfer.sh/123abc/gcs.keyfile | gpg --output - > gcs.keyfile

# curl --upload-file ./test.csv https://transfer.sh/
# wget https://transfer.sh/VtPwOK/test.csv
# curl -X DELETE https://transfer.sh/VtPwOK/test.csv