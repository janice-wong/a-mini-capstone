require 'pp'
require 'unirest'

while true
  p '-' * 100
  p "Pick an option"
  p "1 - Show all products"
  p "2 - Show a specific product"
  p "3 - Create a product"
  p "Type 'exit' to exit"
  p '-' * 100
  user_input = gets.chomp

  if user_input == "1"
    pp Unirest.get("localhost:3000/products").body
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
  elsif user_input == "exit"
    break
  end
end

