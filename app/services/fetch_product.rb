module Shop
  module Services
    class FetchProduct
      def call(id)
        PRODUCTS.select { |product| product.id == id }.first
      end
    end
  end
end
