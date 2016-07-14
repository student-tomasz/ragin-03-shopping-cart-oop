require 'rubygems'
require 'bundler/setup'

$LOAD_PATH.unshift File.expand_path('../', __FILE__)

require 'json'
require 'sinatra/base'

require 'app/models'
require 'app/services'
require 'app/presenters'
require 'app/routes'

module Shop
  DB_FILE = File.join(File.expand_path('../', __FILE__), 'db', 'seed.json')
  DB = JSON.parse(File.read(DB_FILE), symbolize_names: true)
  PRODUCTS = DB[:products].map { |attrs| Models::Product.new(attrs) }
  CART_ITEMS = DB[:cart_items].map { |attrs| Models::CartItem.new(attrs) }

  class App < Sinatra::Application
    configure do
      set :root, File.expand_path('../app', __FILE__)
      set :public_folder, -> { File.join(root, 'static') }
    end

    use Routes::Cart
    use Routes::Products
  end
end
