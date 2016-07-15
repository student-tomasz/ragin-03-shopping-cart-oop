require_relative 'services/exceptions'

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
      autoload :IncrementOrCreate, 'app/services/cart_items/increment_or_create'
      autoload :UpdateOrCreate, 'app/services/cart_items/update_or_create'
    end
  end
end
