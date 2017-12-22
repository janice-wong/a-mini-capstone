class ProductsController < ApplicationController
  def index
    products = []
    Product.all.each do |product|
      products << {
        name: product.name,
        description: product.description,
        price: product.price,
        image: product.image
      }
    end

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
end
