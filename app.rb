require 'rubygems'
require 'bundler/setup'

Bundler.require
$LOAD_PATH << File.expand_path('../', __FILE__)

require 'app/models'
require 'app/services'
require 'app/routes'

module Shop
  PRODUCTS = [
    {
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_id: 2
    }, {
      id: 2,
      name: 'Data Science Essentials in Python',
      price: 1900,
      vat_id: 2
    }, {
      id: 3,
      name: 'Web Development with Clojure, Second Edition',
      price: 2400,
      vat_id: 2
    }, {
      id: 4,
      name: 'Serverless Single Page Apps',
      price: 3000,
      vat_id: 2
    }, {
      id: 5,
      name: 'Deploying with JRuby 9k',
      price: 1600,
      vat_id: 2
    }, {
      id: 6,
      name: 'Pragmatic T-Shirt',
      price: 900,
      vat_id: 1
    }
  ].map { |attrs| Models::Product.new(attrs) }

  CART = [
    {
      product_id: 1,
      quantity: 17
    }, {
      product_id: 2,
      quantity: 0
    }, {
      product_id: 3,
      quantity: 8
    }, {
      product_id: 4,
      quantity: 1
    }, {
      product_id: 5,
      quantity: 1
    }, {
      product_id: 1,
      quantity: 2
    }
  ].map { |attrs| Models::CartItem.new(attrs) }

  class App < Sinatra::Application
    configure do
      set :root, File.dirname(__FILE__)
    end

    use Routes::Products
  end
end
