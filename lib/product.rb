require 'securerandom'

require_relative './vat'
require_relative './product/validator'

module Shop
  class Product
    include Validator

    def initialize(id: nil, name:, price: 0, vat_id: 1)
      @id = id || next_id
      @name = name
      @price = price
      @vat = VAT.for_category(vat_id).value
      validate!
    end

    attr_reader :id, :name, :price, :vat

    def price_with_vat
      (price * (1.0 + vat)).ceil
    end

    def to_h
      {
        id: id,
        name: name,
        price: price,
        price_with_vat: price_with_vat,
        vat: vat
      }
    end

    def eql?(other)
      other.instance_of?(self.class) && other.id == id
    end

    alias == eql?

    private

    def next_id
      SecureRandom.uuid
    end
  end
end
