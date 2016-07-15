module Shop
  module Services
    module Products
      class Fetch
        def call(product_id:)
          product = PRODUCTS.find { |product| product.id == product_id }
          raise Products::ProductDoesNotExistError if product.nil?
          product
        end
      end
    end
  end
end
