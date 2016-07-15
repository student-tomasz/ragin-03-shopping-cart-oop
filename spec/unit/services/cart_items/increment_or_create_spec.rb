module Shop
  module Services
    module CartItems
      RSpec.describe IncrementOrCreate do
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

          shared_examples 'raises Products::ProductDoesNotExistError' do |product_id|
            it 'raises Products::ProductDoesNotExistError' do
              expect { IncrementOrCreate.new.call(product_id: product_id) }
                .to raise_error(Products::ProductDoesNotExistError)
            end
          end

          context 'with a nil id' do
            include_examples 'raises Products::ProductDoesNotExistError', nil
          end

          context "with a non-existant Product's id" do
            include_examples 'raises Products::ProductDoesNotExistError', -1
          end

          context "with an existing Product's id that's not in the cart" do
            it 'creates a new CartItem' do
              expect { Fetch.new.call(product_id: not_in_cart_product.id) }
                .to raise_error(CartItems::CartItemDoesNotExistError)
              IncrementOrCreate.new.call(product_id: not_in_cart_product.id)
              expect { Fetch.new.call(product_id: not_in_cart_product.id) }
                .not_to raise_error
            end
          end

          context "with an existing Product's id that's already in the cart" do
            it 'increments the CartItem#quantity' do
              expect { IncrementOrCreate.new.call(product_id: in_cart_product.id) }
                .to change { Fetch.new.call(product_id: in_cart_product.id).quantity }
                .from(0).to(1)
            end
          end
        end
      end
    end
  end
end
