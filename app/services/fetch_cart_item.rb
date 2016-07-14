module Shop
  module Services
    class FetchCartItem
      def call(product_id:)
        CART_ITEMS.find { |cart_item| cart_item.product.id == product_id }
      end
    end
  end
end
