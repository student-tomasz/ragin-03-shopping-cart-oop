module Shop
  module Services
    module CartItems
      class FetchAll
        def call
          ::Shop::CART_ITEMS ||= []
        end
      end
    end
  end
end
