require_relative './exceptions'

module Shop
  class Product
    module Validator
      include Exceptions

      private

      def validate!
        raise InvalidIdError unless id_valid?
        raise InvalidNameError unless name_valid?
        raise InvalidPriceError unless price_valid?
        raise InvalidVatError unless vat_valid?
      end

      def id_valid?
        !@id.nil?
      end

      def name_valid?
        !@name.nil? && @name.is_a?(String) && !@name.empty? && @name.length >= 2
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
