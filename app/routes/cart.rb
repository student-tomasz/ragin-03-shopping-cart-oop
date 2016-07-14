module Shop
  module Routes
    class Cart < Base
      get '/cart' do
        cart_items = Services::FetchCartItems.new.call
        cart = Models::Cart.new(cart_items)
        cart_presenter = Presenters::Cart.new(cart)
        erb :'cart/index', locals: { cart: cart_presenter }
      end

      post '/cart' do
        Services::AddProductToCart.new.call(product_id: params['product_id'])
        redirect '/cart'
      end
    end
  end
end
