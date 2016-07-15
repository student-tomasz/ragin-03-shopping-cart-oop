module Shop
  module Services
    class SetProductQuantityInCart
      def call(product_id:, quantity:)
        cart_item = FetchCartItem.new.call(product_id: product_id)
        if cart_item
          cart_item.quantity = quantity
        else
          cart_item = Models::CartItem.new(product_id: product_id, quantity: quantity)
          CART_ITEMS << cart_item
        end
        cart_item
      end
    end
  end
end
