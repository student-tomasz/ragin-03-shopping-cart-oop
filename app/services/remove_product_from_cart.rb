module Shop
  module Services
    class RemoveProductFromCart
      def call(product_id:)
        CART_ITEMS.delete_if { |cart_item| cart_item.product.id == product_id }
      end
    end
  end
end
