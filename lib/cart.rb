require 'lib/cart_item'

class Cart
  def initialize(inventory)
    @inventory = inventory
    @items = {}
  end

  def items
    @items.values
  end

  def add(product)
    raise(ArgumentError) if product.nil?
    return nil unless @inventory.reserve(product)
    item = @items[product.id] ||= CartItem.new(product)
    item.increment
    item.quantity
  end

  def remove(product)
    raise(ArgumentError) if product.nil?
    raise(ArgumentError) unless @items.key?(product.id)
    item = @items[product.id]
    item.decrement
    @items.delete(product.id) if item.quantity <= 0
    item.quantity
  end

  def quantity(product)
    raise ArgumentError unless product
    return 0 unless @items.key?(product.id)
    @items[product.id].quantity
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
