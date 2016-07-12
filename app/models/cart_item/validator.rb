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
          raise CartItem::InvalidQuantityError unless quantity_valid?
        end

        private

        def product_id_valid?
          product = @cart_item.product
          !product.nil?
        end

        def quantity_valid?
          quantity = @cart_item.quantity
          !quantity.nil? && quantity.is_a?(Integer) && quantity >= 0
        end
      end
    end
  end
end
