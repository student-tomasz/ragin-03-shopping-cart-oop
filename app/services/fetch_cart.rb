module Shop
  module Services
    class FetchCart
      def call
        Models::Cart.new(CART)
      end
    end
  end
end
