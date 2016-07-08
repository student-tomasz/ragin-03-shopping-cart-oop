require 'lib/inventory_item'

class Inventory
  def initialize(catalog, quantities = Hash.new(0))
    raise(ArgumentError) if catalog.nil?
    @items = Hash[
      catalog.all.map do |product|
        [product.id, InventoryItem.new(product, quantities[product.id])]
      end
    ]
  end

  def reserve(product)
    raise(ArgumentError) unless @items.key?(product.id)
    item = @items[product.id]
    if item.quantity < 1
      false
    else
      item.decrement
      true
    end
  end

  def release(product)
    raise(ArgumentError) unless @items.key?(product.id)
    @items[product.id].increment
    true
  end

  def quantity(product)
    raise(ArgumentError) unless @items.key?(product.id)
    @items[product.id].quantity
  end

  def available?(product)
    raise(ArgumentError) unless @items.key?(product.id)
    quantity(product) >= 1
  end

  def to_h
    {
      inventory: @items.values.map(&:to_h)
    }
  end
end
