module Shop
  module Services
    module CartItems
      RSpec.describe Delete do
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

          let(:book_cart_item) { Models::CartItem.new(product_id: book.id) }

          before :each do
            stub_const('Shop::CART_ITEMS', [book_cart_item])
          end

          context 'with nil id' do
            it 'returns nil' do
              expect(Delete.new.call(product_id: nil))
                .to be nil
            end
          end

          context 'with unknown id' do
            it 'returns nil' do
              expect(Delete.new.call(product_id: -1))
                .to be nil
            end
          end

          context 'with valid id' do
            it 'deletes the requested item' do
              expect { Delete.new.call(product_id: book.id) }
                .to change { Fetch.new.call(product_id: book.id) }
                .from(book_cart_item).to(nil)
            end

            it 'returns the deleted item' do
              expect(Delete.new.call(product_id: book.id))
                .to eq(book_cart_item)
            end
          end
        end
      end
    end
  end
end
