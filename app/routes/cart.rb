module Shop
  module Routes
    class Cart < Base
      get '/cart' do
        cart = Services::FetchCart.new.call
        cart_presenter = Presenters::Cart.new(cart)
        erb :'cart/index', locals: { cart: cart_presenter }
      end
    end
  end
end
