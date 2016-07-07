require 'lib/inventory_item'

class CartItem < InventoryItem
  def initialize(product)
    super(product, 0)
  end

  def total
    @total ||= product.price * @quantity
  end

  def total_with_vat
    @total_with_vat ||= product.price_with_vat * @quantity
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
