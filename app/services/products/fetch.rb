module Shop
  module Services
    module Products
      class Fetch
        def call(product_id:)
          found_product = PRODUCTS.find { |product| product.id == product_id }
          raise Products::ProductDoesNotExistError if found_product.nil?
          found_product
        end
      end
    end
  end
end
