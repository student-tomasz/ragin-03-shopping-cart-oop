module Shop
  module Services
    module CartItems
      class Increment
        InvalidProductIdError = Class.new(ArgumentError)

        def call(product_id:)
          cart_item = Fetch.new.call(product_id: product_id)
          if cart_item
            set_quantity(product_id, cart_item.quantity + 1)
          else
            create_new_cart_item!(product_id)
          end
        end

        private

        def set_quantity(product_id, quantity)
          SetQuantity.new.call(
            product_id: product_id,
            quantity: quantity
          )
        end

        def create_new_cart_item!(product_id)
          cart_item = begin
            Models::CartItem.new(product_id: product_id, quantity: 1)
          rescue
            raise InvalidProductIdError
          end
          CART_ITEMS << cart_item
          cart_item
        end
      end
    end
  end
end
