module Shop
  module Models
    class CartItem
      module Exceptions
        InvalidProductIdError = Class.new(ArgumentError)
        InvalidQuantityTypeError = Class.new(ArgumentError)
        InvalidQuantityValueError = Class.new(ArgumentError)
      end
    end
  end
end
