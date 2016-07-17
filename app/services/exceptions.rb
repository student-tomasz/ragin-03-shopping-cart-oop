module Shop
  module Services
    module Products
      ProductDoesNotExistError = Class.new(ArgumentError)
    end

    module CartItems
      CartItemDoesNotExistError = Class.new(ArgumentError)
      InvalidQuantityError = Class.new(ArgumentError)
    end
  end
end
