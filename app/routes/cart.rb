module Shop
  module Routes
    class Cart < Sinatra::Application
      configure do
        set :root, File.expand_path('../../', __FILE__)
      end

      get '/cart' do
        cart = Services::FetchCart.new.call
        cart_presenter = Presenters::Cart.new(cart)
        erb :'cart/index', locals: { cart: cart_presenter }
      end
    end
  end
end
