module Shop
  module Services
    module CartItems
      class IncrementOrCreate
        def call(product_id:)
          cart_item = find product_id
          if cart_item
            update_cart_item product_id, cart_item.quantity + 1
          else
            cart_item = create! product_id
            persist cart_item
          end
          cart_item
        end

        private

        def find(product_id)
          Fetch.new.call(product_id: product_id)
        rescue CartItems::CartItemDoesNotExistError
          nil
        end

        def update_cart_item(product_id, quantity)
          UpdateOrCreate.new.call(
            product_id: product_id,
            quantity: quantity
          )
        end

        def create!(product_id)
          Models::CartItem.new(product_id: product_id, quantity: 1)
        rescue Models::CartItem::InvalidProductIdError
          raise Products::ProductDoesNotExistError
        end

        def persist(cart_item)
          CART_ITEMS << cart_item
        end
      end
    end
  end
end
