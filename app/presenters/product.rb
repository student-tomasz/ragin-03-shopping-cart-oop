require 'forwardable'
require 'app/presenters/helpers/format_price'

module Shop
  module Presenters
    class Product
      extend Forwardable
      include Helpers::FormatPrice

      InvalidProductError = Class.new(ArgumentError)

      def initialize(product)
        raise InvalidProductError unless product.is_a?(Models::Product)
        @product = product
      end

      attr_reader :product

      def price
        format_price(product.price)
      end

      def price_with_vat
        format_price(product.price_with_vat)
      end

      def vat
        format("%d\%", product.vat * 100.0)
      end

      def_delegators :product, :id, :name
    end
  end
end
