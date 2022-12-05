# README

1. "seeds.db": I parsed the CSV file "Flower_Table.csv" to get data, and use "source.unsplash.com" to download images.  
If we download many images, it sometimes does not work. Feel free to modify the "max_products = 50"
2. Images uploaded to Google Cloud Storage (development & production).
If we want to save images in local development, modify "config.active_storage.service = :local" at config/environments/development.rb
If we want to save images to Google Cloud Storage, you have to sign up a new account and update the key file "gcs.keyfile"
3. If you want to use Docker, please modify PUBLISHABLE_KEY & SECRET_KEY for Stripe. It's not the best practice to add them here.
Please use ENV file.
