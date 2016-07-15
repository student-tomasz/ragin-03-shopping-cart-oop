module Shop
  module Routes
    class Products < Base
      get '/products' do
        products = Services::Products::FetchAll.new.call
        products_presenters = products.map do |product|
          Presenters::Product.new(product)
        end
        erb :'products/index', locals: { products: products_presenters }
      end
    end
  end
end
