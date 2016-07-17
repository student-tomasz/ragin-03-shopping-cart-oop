module Shop
  module Services
    module CartItems
      RSpec.shared_context 'shared global state stubs' do
        let(:in_cart_product) do
          Models::Product.new(
            name: 'Agile Web Development with Rails 5',
            price: 2800,
            vat_id: 2
          )
        end

        let(:not_in_cart_product) do
          Models::Product.new(
            name: 'Pragmatic T-Shirt',
            price: 900,
            vat_id: 1
          )
        end

        before :each do
          stub_const('Shop::PRODUCTS', [in_cart_product, not_in_cart_product])
        end

        let(:cart_item) { Models::CartItem.new(product_id: in_cart_product.id) }

        before :each do
          stub_const('Shop::CART_ITEMS', [cart_item])
        end
      end
    end
  end
end
