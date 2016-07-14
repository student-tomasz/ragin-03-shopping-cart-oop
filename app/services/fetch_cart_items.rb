module Shop
  module Services
    class FetchCartItems
      def call
        CART_ITEMS
      end
    end
  end
end
