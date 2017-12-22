require 'faker'

15.times do
  product = Product.create(
    name: Faker::Lorem.word,
    price: Faker::Number.decimal(2),
    description: Faker::Lorem.sentence(3)
  )

  product.update(
    image: "Image + #{product.id}"
  )
end
