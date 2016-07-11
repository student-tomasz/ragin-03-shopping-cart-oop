module Shop
  class Product
    module Exceptions
      class ProductError < StandardError; end

      class InvalidIdError < ProductError; end

      class InvalidNameError < ProductError; end

      class InvalidPriceError < ProductError; end

      class InvalidVatError < ProductError; end
    end
  end
end
