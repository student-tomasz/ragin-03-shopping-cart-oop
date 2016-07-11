module Shop
  class Product
    module Validator
      def are_valid?(id:, name:, price:, vat_category_id:)
        id_valid?(id) &&
          name_valid?(name) &&
          price_valid?(price) &&
          vat_category_id_valid?(vat_category_id)
      end

      private

      def id_valid?(id)
        !id.nil?
      end

      def name_valid?(name)
        !name.nil? && name.is_a?(String) && !name.empty?
      end

      def price_valid?(price)
        !price.nil? && price.is_a?(Integer) && price >= 0
      end

      def vat_category_id_valid?(id)
        !id.nil? && id.is_a?(Integer) && id.between?(1, 2)
      end
    end
  end
end
