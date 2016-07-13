module Shop
  module Presenters
    class Cart
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
        format('$%.2f', cart.total.to_f / 100.0)
      end

      def total_with_vat
        format('$%.2f', cart.total_with_vat.to_f / 100.0)
      end
    end
  end
end
