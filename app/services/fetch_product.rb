module Shop
  module Services
    class FetchProduct
      def call(product_id:)
        PRODUCTS.find { |product| product.id == product_id }
      end
    end
  end
end
