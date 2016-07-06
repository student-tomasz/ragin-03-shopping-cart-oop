require_relative './products'

class CartItem
  def initialize(product_id)
    @product = Products.find(product_id) || raise(ArgumentError)
    @quantity = 0
  end

  attr_reader :product, :quantity

  def increment
    @quantity += 1
  end

  def decrement
    @quantity -= 1 unless @quantity <= 0
  end

  def total
    @product.price * @quantity
  end

  def total_with_vat
    @product.price_with_vat * @quantity
  end

  def to_h
    {
      product: @product.to_h,
      quantity: @quantity,
      total: total,
      total_with_vat: total_with_vat
    }
  end
end
