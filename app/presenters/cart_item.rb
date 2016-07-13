require 'app/presenters/helpers/format_price'

module Shop
  module Presenters
    class CartItem
      include Helpers::FormatPrice

      InvalidCartItemError = Class.new(ArgumentError)

      def initialize(cart_item)
        raise InvalidCartItemError unless cart_item.is_a?(Models::CartItem)
        @cart_item = cart_item
      end

      attr_reader :cart_item

      def product
        @product_presenter ||= Presenters::Product.new(cart_item.product)
      end

      def quantity
        cart_item.quantity.to_s
      end

      def total
        format_price(cart_item.total)
      end

      def total_with_vat
        format_price(cart_item.total_with_vat)
      end
    end
  end
end
