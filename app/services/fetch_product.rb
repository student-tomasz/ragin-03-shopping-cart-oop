module Shop
  module Services
    class FetchProduct
      def call(product_id)
        PRODUCTS.select { |product| product.id == product_id }.first
      end
    end
  end
end
