module Shop
  module Models
    class CartItem
      module Exceptions
        class CartItemError < ArgumentError; end
        class InvalidProductIdError < CartItemError; end
        class InvalidQuantityError < CartItemError; end
      end
    end
  end
end
