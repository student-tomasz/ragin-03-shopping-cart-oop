module Shop
  module Services
    module CartItems
      RSpec.describe UpdateOrCreate do
        include_context 'shared global state stubs'

        describe '#call' do
          shared_examples 'raises Products::ProductDoesNotExistError' do |product_id|
            it 'raises Products::ProductDoesNotExistError' do
              attrs = { product_id: product_id, quantity: 1 }
              expect { UpdateOrCreate.new.call(attrs) }
                .to raise_error(Products::ProductDoesNotExistError)
            end
          end

          shared_examples 'raises CartItems::InvalidQuantityError' do |quantity|
            it 'raises CartItems::InvalidQuantityError' do
              attrs = { product_id: in_cart_product.id, quantity: quantity }
              expect { UpdateOrCreate.new.call(attrs) }
                .to raise_error(CartItems::InvalidQuantityError)
            end
          end

          context 'with a nil id' do
            include_examples 'raises Products::ProductDoesNotExistError', nil
          end

          context "with a non-existant Product's id" do
            include_examples 'raises Products::ProductDoesNotExistError', -1
          end

          context 'with a nil quantity' do
            include_examples 'raises CartItems::InvalidQuantityError', nil
          end

          context 'with a non-Numeric quantity' do
            include_examples 'raises CartItems::InvalidQuantityError', 'asd'
          end

          context 'with a non-Integer quantity' do
            include_examples 'raises CartItems::InvalidQuantityError', 13.7
          end

          context "with an existing Product's id that's not in the cart" do
            it 'creates a new CartItem' do
              expect { Fetch.new.call(product_id: not_in_cart_product.id) }
                .to raise_error(CartItems::CartItemDoesNotExistError)
              UpdateOrCreate.new.call(product_id: not_in_cart_product.id, quantity: 17)
              expect { Fetch.new.call(product_id: not_in_cart_product.id) }
                .not_to raise_error
            end
          end

          context "with an existing Product's id that's already in the cart" do
            context 'with quantity > 0' do
              it 'updates the CartItem#quantity' do
                expect { UpdateOrCreate.new.call(product_id: in_cart_product.id, quantity: 17) }
                  .to change { Fetch.new.call(product_id: in_cart_product.id).quantity }
                  .from(1).to(17)
              end
            end

            context 'with quantity <= 0' do
              it 'deletes the CartItem' do
                expect { Fetch.new.call(product_id: in_cart_product.id) }
                  .not_to raise_error
                UpdateOrCreate.new.call(product_id: in_cart_product.id, quantity: 0)
                expect { Fetch.new.call(product_id: in_cart_product.id) }
                  .to raise_error(CartItems::CartItemDoesNotExistError)
              end
            end
          end
        end
      end
    end
  end
end
