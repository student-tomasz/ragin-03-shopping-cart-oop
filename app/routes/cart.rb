module Shop
  module Routes
    class Cart < Sinatra::Application
      configure do
        set :root, File.expand_path('../../', __FILE__)
      end

      get '/cart' do
        cart = Services::FetchCart.new.call
        erb :'cart/index', locals: { cart: cart }
      end
    end
  end
end
