require 'app/presenters/helpers/format_price'

module Shop
  module Presenters
    class Cart
      include Helpers::FormatPrice

      class InvalidCartError < ArgumentError; end

      def initialize(cart)
        raise InvalidCartError unless cart.is_a?(Models::Cart)
        @cart = cart
      end

      attr_reader :cart

      def items
        @items ||= cart.items
      end

      def total
        format_price(cart.total)
      end

      def total_with_vat
        format_price(cart.total_with_vat)
      end
    end
  end
end
