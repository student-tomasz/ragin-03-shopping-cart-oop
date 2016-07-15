module Shop
  module Services
    autoload :AddProductToCart, 'app/services/add_product_to_cart'
    autoload :PlaceProductInCart, 'app/services/place_product_in_cart'
    autoload :FetchCartItems, 'app/services/fetch_cart_items'
    autoload :FetchCartItem, 'app/services/fetch_cart_item'
    autoload :FetchProducts, 'app/services/fetch_products'
    autoload :FetchProduct, 'app/services/fetch_product'
  end
end
