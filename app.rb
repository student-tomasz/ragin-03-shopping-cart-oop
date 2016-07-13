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
  CART = DB[:cart].map { |attrs| Models::CartItem.new(attrs) }

  class App < Sinatra::Application
    use Routes::Cart
    use Routes::Products
  end
end
