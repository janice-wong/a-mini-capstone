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

end
