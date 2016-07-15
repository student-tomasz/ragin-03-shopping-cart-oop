module Shop
  module Services
    module Products
      class Fetch
        def call(product_id:)
          PRODUCTS.find { |product| product.id == product_id }
        end
      end
    end
  end
end
