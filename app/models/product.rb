class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  belongs_to :supplier

  def as_json
    {
      id: id,
      name: name,
      description: description,
      price: price,
      in_stock: in_stock,
      is_discounted: is_discounted,
      tax: tax,
      total: total,
      image: image,
      supplier: supplier
    }
  end

  def is_discounted
    price.to_f < 2
  end

  def tax
    (price * 0.09).round(2)
  end

  def total
    tax + price
  end
end
