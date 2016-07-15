module Shop
  module Services
    module CartItems
      RSpec.describe Fetch do
        describe '#call' do
          let(:in_cart_product) do
            Models::Product.new(
              name: 'Agile Web Development with Rails 5',
              price: 2800,
              vat_id: 2
            )
          end

          let(:not_in_cart_product) do
            Models::Product.new(
              id: 6,
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

          shared_examples 'raises CartItems::CartItemDoesNotExistError' do |product_id|
            it 'raises CartItems::CartItemDoesNotExistError' do
              expect { Fetch.new.call(product_id: product_id) }
                .to raise_error(CartItems::CartItemDoesNotExistError)
            end
          end

          context 'with a nil id' do
            include_examples 'raises CartItems::CartItemDoesNotExistError', nil
          end

          context "with a non-existant Product's id" do
            include_examples 'raises CartItems::CartItemDoesNotExistError', -1
          end

          context "with an existing Product's id that's not in the cart" do
            include_examples 'raises CartItems::CartItemDoesNotExistError', 6 # not_in_cart_product.id
          end

          context 'with a valid id' do
            it 'returns the Models::CartItem requested' do
              expect(Fetch.new.call(product_id: in_cart_product.id))
                .to eq(cart_item)
            end
          end
        end
      end
    end
  end
end
