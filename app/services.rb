module Shop
  module Services
    autoload :AddOneProductToCart, 'app/services/add_one_product_to_cart'
    autoload :SetProductQuantityInCart, 'app/services/set_product_quantity_in_cart'
    autoload :FetchCartItems, 'app/services/fetch_cart_items'
    autoload :FetchCartItem, 'app/services/fetch_cart_item'
    autoload :FetchProducts, 'app/services/fetch_products'
    autoload :FetchProduct, 'app/services/fetch_product'
  end
end
