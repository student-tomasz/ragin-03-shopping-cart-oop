module Shop
  module Models
    class CartItem
      module Exceptions
        InvalidProductIdError = Class.new(ArgumentError)
        InvalidQuantityError = Class.new(ArgumentError)
      end
    end
  end
end
