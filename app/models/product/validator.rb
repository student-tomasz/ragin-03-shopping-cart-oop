module Shop
  module Models
    class Product
      include Exceptions

      class Validator
        def initialize(product)
          @product = product
        end

        def validate!
          id_valid?
          name_valid?
          price_valid?
          vat_valid?
        end

        private

        def id_valid?
          raise Product::InvalidIdError unless @product.id
        end

        def name_valid?
          [
            ->(name) { name.is_a?(String) },
            ->(name) { !name.empty? }
          ].each do |test|
            raise Product::InvalidNameError unless test.call(@product.name)
          end
        end

        def price_valid?
          [
            ->(price) { price.is_a?(Integer) },
            ->(price) { price >= 0 }
          ].each do |test|
            raise Product::InvalidPriceError unless test.call(@product.price)
          end
        end

        def vat_valid?
          raise Product::InvalidVatError unless @product.vat.is_a?(Float)
        end
      end
    end
  end
end
