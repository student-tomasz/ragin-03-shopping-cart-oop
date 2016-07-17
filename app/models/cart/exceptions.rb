module Shop
  module Models
    class Cart
      module Exceptions
        InvalidCartItemsTypeError = Class.new(TypeError)
      end
    end
  end
end
