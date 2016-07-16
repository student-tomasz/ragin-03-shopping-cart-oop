module Shop
  module Services
    module CartItems
      class Fetch
        def call(product_id:)
          found_cart_item = CART_ITEMS.find do |cart_item|
            cart_item.product.id == product_id
          end
          raise CartItems::CartItemDoesNotExistError if found_cart_item.nil?
          found_cart_item
        end
      end
    end
  end
end
