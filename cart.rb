require_relative './catalog'
require_relative './cart_item'

class Cart
  def initialize
    @items = {}
  end

  def add(product_id)
    raise(ArgumentError) unless Catalog.has? product_id
    item = @items[product_id] ||= CartItem.new(product_id)
    item.increment
    item.quantity
  end

  def remove(product_id)
    raise(ArgumentError) unless @items.key? product_id
    item = @items[product_id]
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
