module Shop
  module Presenters
    module Helpers
      module FormatPrice
        def format_price(price_in_cents)
          format('$%.2f', price_in_cents.to_f / 100.0)
        end
      end
    end
  end
end
