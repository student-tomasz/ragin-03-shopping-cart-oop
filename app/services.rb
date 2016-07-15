module Shop
  module Services
    module Products
      autoload :FetchAll, 'app/services/products/fetch_all'
      autoload :Fetch, 'app/services/products/fetch'
    end

    module CartItems
      autoload :Delete, 'app/services/cart_items/delete'
      autoload :FetchAll, 'app/services/cart_items/fetch_all'
      autoload :Fetch, 'app/services/cart_items/fetch'
      autoload :Increment, 'app/services/cart_items/increment'
      autoload :SetQuantity, 'app/services/cart_items/set_quantity'
    end
  end
end
