module Shop
  module Services
    module CartItems
      class Fetch
        def call(product_id:)
          cart_item = CART_ITEMS.find { |cart_item| cart_item.product.id == product_id }
          raise CartItems::CartItemDoesNotExistError if cart_item.nil?
          cart_item
        end
      end
    end
  end
end
