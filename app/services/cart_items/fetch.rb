module Shop
  module Services
    module CartItems
      class Fetch
        def call(product_id:)
          CART_ITEMS.find { |cart_item| cart_item.product.id == product_id }
        end
      end
    end
  end
end
