module Shop
  module Models
    class Product
      module Exceptions
        InvalidIdError = Class.new(ArgumentError)
        InvalidNameError = Class.new(ArgumentError)
        InvalidPriceError = Class.new(ArgumentError)
        InvalidVatError = Class.new(ArgumentError)
      end
    end
  end
end
