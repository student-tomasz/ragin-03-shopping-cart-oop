require_relative './vat'

class Product
  def initialize(id:, name:, price:, vat_category_id:)
    @id = id
    @name = name
    @price = price
    @vat_category_id = vat_category_id
  end

  attr_reader :id, :name, :price, :vat_category_id

  def vat
    VAT.for_category(@vat_category_id)
  end

  def price_with_vat
    (@price * (1.0 + vat.value)).ceil
  end

  def eql?(other)
    other.instance_of?(self.class) && other.id == @id
  end

  alias == eql?
end
