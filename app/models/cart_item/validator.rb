module Shop
  module Models
    class CartItem
      include Exceptions

      class Validator
        def initialize(cart_item)
          @cart_item = cart_item
        end

        def validate!
          raise CartItem::InvalidProductIdError unless product_id_valid?
          raise CartItem::InvalidQuantityTypeError unless quantity_type_valid?
          raise CartItem::InvalidQuantityValueError unless quantity_value_valid?
        end

        private

        def product_id_valid?
          !@cart_item.product.nil?
        end

        def quantity_type_valid?
          quantity = @cart_item.quantity
          !quantity.nil? && quantity.is_a?(Integer)
        end

        def quantity_value_valid?
          @cart_item.quantity > 0
        end
      end
    end
  end
end
