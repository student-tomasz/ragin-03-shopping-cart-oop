module Shop
  module Routes
    class Cart < Base
      get '/cart' do
        cart_items = Services::CartItems::FetchAll.new.call
        cart = Models::Cart.new(cart_items)
        cart_presenter = Presenters::Cart.new(cart)
        erb :'cart/index', locals: { cart: cart_presenter }
      end

      post '/cart' do
        Services::CartItems::IncrementOrCreate.new.call(
          product_id: params['product_id']
        )
        redirect '/cart'
      end

      put '/cart' do
        Services::CartItems::UpdateOrCreate.new.call(
          product_id: params['product_id'],
          quantity: Integer(params['quantity'])
        )
        redirect '/cart'
      end

      delete '/cart' do
        Services::CartItems::Delete.new.call(
          product_id: params['product_id']
        )
        redirect '/cart'
      end
    end
  end
end
