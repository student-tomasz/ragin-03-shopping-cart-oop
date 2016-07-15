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
        Services::AddOneProductToCart.new.call(product_id: params['product_id'])
        redirect '/cart'
      end

      put '/cart' do
        Services::SetProductQuantityInCart.new.call(
          product_id: params['product_id'],
          quantity: Integer(params['quantity'])
        )
        redirect '/cart'
      end

      delete '/cart' do
        Services::RemoveProductFromCart.new.call(
          product_id: params['product_id']
        )
        redirect '/cart'
      end
    end
  end
end
