module Shop
  module Models
    class Cart
      include Exceptions

      class Validator
        def initialize(cart)
          @cart = cart
        end

        def validate!
          cart_items_only?
        end

        private

        def cart_items_only?
          raise Cart::InvalidCartItemsTypeError unless @cart.items.is_a?(Array)
          @cart.items.each do |item|
            raise Cart::InvalidCartItemsTypeError unless item.is_a?(CartItem)
          end
        end
      end
    end
  end
end
