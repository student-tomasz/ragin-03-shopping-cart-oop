module Shop
  module Routes
    class Products < Sinatra::Application
      configure do
        set :root, File.expand_path('../../', __FILE__)
      end

      get '/products' do
        products = Services::FetchProducts.new.call
        erb :'products/index', locals: { products: products }
      end
    end
  end
end
