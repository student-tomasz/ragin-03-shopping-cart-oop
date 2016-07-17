module Shop
  module Services
    module Products
      class FetchAll
        def call
          ::Shop::PRODUCTS ||= []
        end
      end
    end
  end
end
