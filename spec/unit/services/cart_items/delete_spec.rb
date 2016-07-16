require_relative './shared_global_state_stubs'

module Shop
  module Services
    module CartItems
      RSpec.describe Delete do
        include_context 'shared global state stubs'

        describe '#call' do
          shared_examples 'raises CartItems::CartItemDoesNotExistError' do |product_id|
            it 'raises CartItems::CartItemDoesNotExistError' do
              expect { Delete.new.call(product_id: product_id) }
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
            # As the `not_in_cart_product.id` is unavailable in this scope I've
            # had to use its literal value.
            include_examples 'raises CartItems::CartItemDoesNotExistError', 6
          end

          context 'with a valid id' do
            it 'deletes the requested item' do
              Delete.new.call(product_id: in_cart_product.id)
              expect { Delete.new.call(product_id: in_cart_product.id) }
                .to raise_error(CartItemDoesNotExistError)
            end

            it 'returns the deleted item' do
              expect(Delete.new.call(product_id: in_cart_product.id))
                .to eq(cart_item)
            end
          end
        end
      end
    end
  end
end
