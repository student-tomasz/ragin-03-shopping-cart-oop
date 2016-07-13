module Shop
  module Routes
    class Products < Base
      get '/products' do
        products = Services::FetchProducts.new.call
        products_presenters = products.map { |product| Presenters::Product.new(product) }
        erb :'products/index', locals: { products: products_presenters }
      end
    end
  end
end
