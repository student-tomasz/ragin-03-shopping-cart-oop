module Shop
  class Product
    module Validator
      private

      def valid?
        id_valid? &&
          name_valid? &&
          price_valid? &&
          vat_valid?
      end

      def id_valid?
        !@id.nil?
      end

      def name_valid?
        !@name.nil? && @name.is_a?(String) && !@name.empty?
      end

      def price_valid?
        !@price.nil? && @price.is_a?(Integer) && @price >= 0
      end

      def vat_valid?
        !vat.nil? && vat.is_a?(Float)
      end
    end
  end
end
