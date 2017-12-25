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
  p "6 - Sign up"
  p "7 - Log in"
  p "8 - Log out"
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
  elsif user_input == "6"
    create_user = {}
    p "Enter your name:"
    create_user[:name] = gets.chomp
    p "Enter your email:"
    create_user[:email] = gets.chomp
    p "Enter your password:"
    create_user[:password] = gets.chomp
    p "Confirm your password:"
    create_user[:password_confirmation] = gets.chomp

    pp Unirest.post("localhost:3000/users", parameters: create_user).body
  elsif user_input == "7"
    p "Enter your email:"
    email_input = gets.chomp
    p "Enter your password:"
    password_input = gets.chomp

    log_in = Unirest.post(
      "localhost:3000/user_token",
      parameters: {
        auth: {
          email: email_input,
          password: password_input
        }
      }
    )

    # Save JSON web token from response
    jwt = log_in.body["jwt"]
    if jwt
      p "Login successful - your JSON web token is #{jwt}."
    else
      p "Login unsuccessful"
    end

    # Include jwt in headers of future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif user_input == "8"
    jwt = ""
    Unirest.clear_default_headers
    p "Logged out"
  elsif user_input == "exit"
    break
  end
end

