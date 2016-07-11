module Shop
  class Product
    include Exceptions
    
    class Validator
      def initialize(product)
        @product = product
      end

      def validate!
        raise Exceptions::InvalidIdError unless id_valid?
        raise Exceptions::InvalidNameError unless name_valid?
        raise Exceptions::InvalidPriceError unless price_valid?
        raise Exceptions::InvalidVatError unless vat_valid?
      end

      private

      def id_valid?
        id = @product.id
        !id.nil?
      end

      def name_valid?
        name = @product.name
        !name.nil? && name.is_a?(String) && !name.empty? && name.length >= 2
      end

      def price_valid?
        price = @product.price
        !price.nil? && price.is_a?(Integer) && price >= 0
      end

      def vat_valid?
        vat = @product.vat
        !vat.nil? && vat.is_a?(Float)
      end
    end
  end
end
