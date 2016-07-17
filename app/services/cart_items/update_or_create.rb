module Shop
  module Services
    module CartItems
      # Naming this service is a serious PITA. It solely depends on :quantity's
      # value as to what actaully needs to be done. So:
      # - it either updates the CartItem#quantity to the provided value,
      # - OR creates a CartItem when there was none,
      # - OR deletes the CartItem if :quantity given is below 1.
      class UpdateOrCreate
        def call(product_id:, quantity:)
          new_cart_item = create! product_id, quantity
          delete product_id
          persist new_cart_item if new_cart_item
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
          cart_item
        end
      end
    end
  end
end
