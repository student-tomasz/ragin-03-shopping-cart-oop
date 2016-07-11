require_relative './vat'
require_relative './product/validator'

module Shop
  class Product
    include Validator

    def initialize(id:, name:, price: 0, vat_category_id: 1)
      @id = id
      @name = name
      @price = price
      @vat_category_id = vat_category_id
      raise ArgumentError unless valid?
    end

    attr_reader :id, :name, :price

    def vat
      VAT.for_category(@vat_category_id).value
    end

    def price_with_vat
      (@price * (1.0 + vat)).ceil
    end

    def to_h
      {
        id: @id,
        name: @name,
        price: @price,
        price_with_vat: price_with_vat,
        vat: vat
      }
    end

    def eql?(other)
      other.instance_of?(self.class) && other.id == @id
    end

    alias == eql?
  end
end
