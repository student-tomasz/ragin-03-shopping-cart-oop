module Shop
  module Models
    class CartItem
      include Exceptions

      class Validator
        def initialize(cart_item)
          @cart_item = cart_item
        end

        def validate!
          product_id_valid?
          quantity_type_valid?
          quantity_value_valid?
        end

        private

        def product_id_valid?
          raise CartItem::InvalidProductIdError unless @cart_item.product
        end

        def quantity_type_valid?
          raise CartItem::InvalidQuantityTypeError unless @cart_item.quantity.is_a?(Integer)
        end

        def quantity_value_valid?
          raise CartItem::InvalidQuantityValueError if @cart_item.quantity <= 0
        end
      end
    end
  end
end
