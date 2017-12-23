class ProductsController < ApplicationController
  def index
    price = :price if params[:price_sort].downcase == "y"
    products = Product.all.where("name LIKE ?", "%#{params[:keyword]}%").order(price)

    render json: products.as_json
  end

  def show
    render json: Product.find(params[:id]).as_json
  end

  def create
    product = Product.new(
      name: params[:name],
      description: params[:description],
      price: params[:price].to_f,
      image: params[:image],
    )

    if product.save
      render json: { product: product }
    else
      render json: { error: product.errors.full_messages }
    end
  end

  def update
    product = Product.find(params[:id])

    name = params[:name] || product.name
    description = params[:description] || product.description
    price = params[:price] || product.price
    image = params[:image] || product.image

    if product.update(
      name: name,
      description: description,
      price: price,
      image: image
    )
      render json: product.as_json
    else
      render json: { error: product.errors.full_messages }
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product
      product.destroy
      render json: { message: "Product deleted" }
    else
      render json: { error: "No product with ID of #{params[:id]}" }
    end
  end

  def product_ids
    render json: { ids: Product.all.map { |product| product.id } }
  end
end
