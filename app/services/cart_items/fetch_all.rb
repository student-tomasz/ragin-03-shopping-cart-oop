module Shop
  module Services
    module CartItems
      class FetchAll
        def call
          CART_ITEMS
        end
      end
    end
  end
end
