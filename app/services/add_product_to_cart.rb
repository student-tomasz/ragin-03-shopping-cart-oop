module Shop
  module Services
    class AddProductToCart
      def call(product_id:)
        cart_item = FetchCartItem.new.call(product_id: product_id)
        if cart_item
          cart_item.quantity += 1
        else
          cart_item = Models::CartItem.new(product_id: product_id, quantity: 1)
          CART_ITEMS.unshift(cart_item)
        end
        cart_item
      end
    end
  end
end
