require_relative './cart_item'
require_relative './products'

class Cart
  def initialize
    @items = {}
  end

  def add(product_id)
    product = Products.find(product_id) || raise(ArgumentError)
    item = @items[product.id] ||= CartItem.new(product.id)
    item.increment
    item.quantity
  end

  def remove(product_id)
    item = @items[product_id] || raise(ArgumentError)
    item.decrement
    @items.delete(product_id) if item.quantity <= 0
    item.quantity
  end

  def items
    @items.values
  end

  def total
    @items.values.reduce(0) { |a, e| a + e.total }
  end

  def total_with_vat
    @items.values.reduce(0) { |a, e| a + e.total_with_vat }
  end

  def to_h
    {
      items: @items.values.map(&:to_h),
      total: total,
      total_with_vat: total_with_vat
    }
  end
end
