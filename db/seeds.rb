# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.find_or_create_by(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end

categories = ['Electronics', 'Books', 'Home & Kitchen', 'Toys & Games']
categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

categories.each do |category_name|
  category = Category.find_by(name: category_name)

  25.times do
    product = Product.create(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence(word_count: 10),
      price: Faker::Commerce.price(range: 0.99..99.99),
      category_id: category.id,
      quantity: Faker::Number.between(from: 1, to: 100),
      active: Faker::Boolean.boolean,
      new: Faker::Boolean.boolean,
      image_url: Faker::LoremFlickr.image(size: "30x30", search_terms: [category_name.downcase])
    )
  end
end



