class InventoryItem
  def initialize(product, quantity = 0)
    raise(ArgumentError) if product.nil?
    raise(ArgumentError) if !quantity.is_a?(Integer) || quantity < 0
    @product = product
    @quantity = quantity
  end

  attr_reader :product, :quantity

  def increment
    @quantity += 1
  end

  def decrement
    @quantity -= 1 unless @quantity <= 0
  end

  def to_h
    {
      product: @product.to_h,
      quantity: @quantity
    }
  end
end
