module Shop
  module Models
    class Cart
      class Validator
        def initialize(cart)
          @cart = cart
        end

        def validate!
          raise ArgumentError if @cart.items.nil?
          raise ArgumentError unless cart_items_only?
        end

        private

        def cart_items_only?
          @cart.items.each do |item|
            return false unless item.is_a?(CartItem)
          end
          true
        end
      end
    end
  end
end
