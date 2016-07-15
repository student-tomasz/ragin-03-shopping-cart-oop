module Shop
  module Services
    module CartItems
      class IncrementOrCreate
        ProductDoesNotExistError = Class.new(ArgumentError)

        def call(product_id:)
          cart_item = find(product_id)
          if cart_item
            set_quantity(product_id, cart_item.quantity + 1)
          else
            cart_item = create!(product_id)
            persist(cart_item)
          end
        end

        private

        def find(product_id)
          Fetch.new.call(product_id: product_id)
        end

        def set_quantity(product_id, quantity)
          SetQuantity.new.call(
            product_id: product_id,
            quantity: quantity
          )
        end

        def create!(product_id)
          Models::CartItem.new(product_id: product_id, quantity: 1)
        rescue
          raise ProductDoesNotExistError
        end

        def persist(cart_item)
          CART_ITEMS << cart_item
          cart_item
        end
      end
    end
  end
end
