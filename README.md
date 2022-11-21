# README

Seed data:
1. Parsing CSV file, and use "source.unsplash.com" to download images.  
If we download manage images, it sometimes does not work. Feel free to modify the "max_products = 50"
2. Images uploaded to Google Cloud Storage (development & production.)
If we want to save images in local development, modify "config.active_storage.service = :local" at config/environments/development.rb