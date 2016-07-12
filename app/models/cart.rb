module Shop
  module Models
    class Cart
      def initialize
        @items = Services::FetchCart.new.call
      end

      attr_reader :items

      def total
        @items.map(&:total).reduce(0, :+)
      end

      def total_with_vat
        @items.map(&:total_with_vat).reduce(0, :+)
      end

      def to_h
        {
          items: @items.map(&:to_h),
          total: total,
          total_with_vat: total_with_vat
        }
      end
    end
  end
end
