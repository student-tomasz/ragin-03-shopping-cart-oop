require 'forwardable'

module Shop
  module Presenters
    class Product
      extend Forwardable

      def initialize(product)
        raise ArgumentError unless product.is_a?(Models::Product)
        @product = product
      end

      def name
        @product.name
      end

      def price
        format('$%.2f', @product.price.to_f / 100.0)
      end

      def price_with_vat
        format('$%.2f', @product.price_with_vat.to_f / 100.0)
      end

      def vat
        format("%d\%", @product.vat * 100.0)
      end

      def_delegators :@product, :id, :name
    end
  end
end
