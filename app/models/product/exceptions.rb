module Shop
  module Models
    class Product
      module Exceptions
        class ProductError < ArgumentError; end
        class InvalidIdError < ProductError; end
        class InvalidNameError < ProductError; end
        class InvalidPriceError < ProductError; end
        class InvalidVatError < ProductError; end
      end
    end
  end
end
