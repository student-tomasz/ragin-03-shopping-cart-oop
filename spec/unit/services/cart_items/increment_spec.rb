module Shop
  module Services
    module CartItems
      RSpec.describe Increment do
        describe '#call' do
          let(:book) do
            Models::Product.new(
              name: 'Agile Web Development with Rails 5',
              price: 2800,
              vat_id: 2
            )
          end

          before :each do
            stub_const('Shop::PRODUCTS', [book])
          end

          let(:book_cart_item) do
            Models::CartItem.new(product_id: book.id, quantity: 1)
          end

          before :each do
            stub_const('Shop::CART_ITEMS', [book_cart_item])
          end

          shared_examples 'raises InvalidProductIdError' do |product_id|
            it 'raises InvalidProductIdError' do
              expect { Increment.new.call(product_id: product_id) }
                .to raise_error(Increment::InvalidProductIdError)
            end
          end

          context 'with nil id' do
            include_examples 'raises InvalidProductIdError', nil
          end

          context 'with unknown id' do
            include_examples 'raises InvalidProductIdError', -1
          end

          context 'with valid id' do
            it 'increments the Models::CartItem#quantity' do
              expect { Increment.new.call(product_id: book.id) }
                .to change { Fetch.new.call(product_id: book.id).quantity }
                .from(1).to(2)
            end
          end
        end
      end
    end
  end
end
