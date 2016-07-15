module Shop
  module Services
    module CartItems
      class SetQuantity
        ProductDoesNotExistError = Class.new(ArgumentError)
        InvalidQuantityError = Class.new(ArgumentError)

        def call(product_id:, quantity:)
          new_cart_item = create! product_id, quantity
          delete product_id
          persist new_cart_item
        end

        private

        def create!(product_id, quantity)
          Models::CartItem.new(
            product_id: product_id,
            quantity: quantity
          )
        rescue Models::CartItem::InvalidProductIdError
          raise ProductDoesNotExistError
        rescue Models::CartItem::InvalidQuantityError
          raise InvalidQuantityError
        end

        def delete(product_id)
          Delete.new.call(product_id: product_id)
        end

        def persist(cart_item)
          CART_ITEMS << cart_item
          cart_item
        end
      end
    end
  end
end
