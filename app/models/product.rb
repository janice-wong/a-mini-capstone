class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  def as_json
    {
      id: id,
      name: name,
      description: description,
      price: price,
      is_discounted: is_discounted,
      tax: tax,
      total: total,
      image: image,
    }
  end

  def is_discounted
    price.to_f < 2
  end

  def tax
    price * 0.09
  end

  def total
    tax + price
  end
end
