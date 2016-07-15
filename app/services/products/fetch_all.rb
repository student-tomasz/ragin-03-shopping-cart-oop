module Shop
  module Services
    module Products
      class FetchAll
        def call
          PRODUCTS
        end
      end
    end
  end
end
