require 'lib/catalog'

class CartItem
  def initialize(product_id)
    raise ArgumentError unless Catalog.has? product_id
    @product_id = product_id
    @quantity = 0
  end

  attr_reader :product_id, :quantity

  def product
    @product ||= Catalog.find @product_id
  end

  def increment
    @quantity += 1
  end

  def decrement
    @quantity -= 1 unless @quantity <= 0
  end

  def total
    product.price * @quantity
  end

  def total_with_vat
    product.price_with_vat * @quantity
  end

  def to_h
    {
      product: product.to_h,
      quantity: @quantity,
      total: total,
      total_with_vat: total_with_vat
    }
  end
end
