require_relative './cart_item/exceptions'
require_relative './cart_item/validator'

module Shop
  module Models
    class CartItem
      def initialize(product_id:, quantity: 1)
        @product = begin
          Services::Products::Fetch.new.call(product_id: product_id)
        rescue
          raise InvalidProductIdError
        end
        @quantity = quantity
        Validator.new(self).validate!
      end

      attr_reader :product, :quantity

      def total
        product.price * @quantity
      end

      def total_with_vat
        product.price_with_vat * @quantity
      end

      def to_h
        {
          product: product.to_h,
          quantity: quantity,
          total: total,
          total_with_vat: total_with_vat
        }
      end

      def eql?(other)
        other.instance_of?(self.class) && other.product.id == product.id
      end
      alias == eql?
    end
  end
end
