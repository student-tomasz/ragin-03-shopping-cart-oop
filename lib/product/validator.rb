module Shop
  class Product
    module Validator
      private

      def valid?
        id_valid? &&
          name_valid? &&
          price_valid? &&
          vat_category_id_valid?
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

      def vat_category_id_valid?
        !@vat_category_id.nil? &&
          @vat_category_id.is_a?(Integer) &&
          @vat_category_id.between?(1, 2)
      end
    end
  end
end
