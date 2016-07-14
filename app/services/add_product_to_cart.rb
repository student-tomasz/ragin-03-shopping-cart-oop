module Shop
  module Services
    class AddProductToCart
      def call(product_id:)
        cart_item = FetchCartItem.new.call(product_id: product_id)
        quantity = cart_item ? cart_item.quantity + 1 : 1

        CART_ITEMS.delete cart_item
        CART_ITEMS.unshift Models::CartItem.new(product_id: product_id, quantity: quantity)
      end
    end
  end
end
