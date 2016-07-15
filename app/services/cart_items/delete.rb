module Shop
  module Services
    module CartItems
      class Delete
        def call(product_id:)
          cart_item = Fetch.new.call(product_id: product_id)
          CART_ITEMS.delete(cart_item)
        end
      end
    end
  end
end
