module Shop
  module Services
    module CartItems
      class UpdateOrCreate
        def call(product_id:, quantity:)
          new_cart_item = create! product_id, quantity
          delete product_id
          persist new_cart_item if new_cart_item
          new_cart_item
        end

        private

        def create!(product_id, quantity)
          Models::CartItem.new(product_id: product_id, quantity: quantity)
        rescue Models::CartItem::InvalidProductIdError
          raise Products::ProductDoesNotExistError
        rescue Models::CartItem::InvalidQuantityTypeError
          raise CartItems::InvalidQuantityError
        rescue Models::CartItem::InvalidQuantityValueError
          nil
        end

        def delete(product_id)
          Delete.new.call(product_id: product_id)
        rescue CartItems::CartItemDoesNotExistError # rubocop:disable Lint/HandleExceptions
          # NOP and that's OK.
          # We want to create a CartItem if one doesn't already exist for
          # the product_id, so there's no point in propagating the exception.
        end

        def persist(cart_item)
          CART_ITEMS << cart_item
        end
      end
    end
  end
end
