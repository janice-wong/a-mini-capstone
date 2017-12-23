require 'pp'
require 'unirest'

while true
  p '-' * 100
  p "Pick an option"
  p "1 - Search products by name"
  p "2 - Show a specific product"
  p "3 - Create a product"
  p "4 - Update a product"
  p "5 - Delete a product"
  p "Type 'exit' to exit"
  p '-' * 100
  user_input = gets.chomp

  if user_input == "1"
    p "Enter a keyword:"
    keyword_input = gets.chomp
    p "Sort by price? (y/n)"
    price_sort_input = gets.chomp
    pp Unirest.get("localhost:3000/products", parameters: { keyword: keyword_input, price_sort: price_sort_input }).body
  elsif user_input == "2"
    p "Provide the ID of the product you want to show:"
    product_id = gets.chomp.to_i
    pp Unirest.get("localhost:3000/products/#{product_id}").body
  elsif user_input == "3"
    product_input = {}
    p "Name:"
    product_input[:name] = gets.chomp
    p "Price:"
    product_input[:price] = gets.chomp
    p "Description:"
    product_input[:description] = gets.chomp
    p "Image:"
    product_input[:image] = gets.chomp
    pp Unirest.post("localhost:3000/products", parameters: product_input).body
  elsif user_input == "4"
    p "Provide the ID of the product you want to update:"
    product_id = gets.chomp.to_i
    if Unirest.get("localhost:3000/product_ids").body["ids"].include? product_id
      product = Unirest.get("localhost:3000/products/#{product_id}").body
      product_update = {}
      product.each do |key, value|
        next if ['id', 'created_at', 'updated_at'].include? key
        p "#{key.capitalize} is currently #{value}. If you want to update it, provide the updated value. Otherwise, press [Enter]."
        input = gets.chomp
        product_update["#{key}"] = input if input != ""
      end
      pp Unirest.patch("localhost:3000/products/#{product_id}", parameters: product_update).body
    else
      p "No product with ID #{product_id} found."
    end
  elsif user_input == "5"
    p "Provide the ID of the product you want to delete:"
    product_id = gets.chomp.to_i
    pp Unirest.delete("localhost:3000/products/#{product_id}").body
  elsif user_input == "exit"
    break
  end
end

