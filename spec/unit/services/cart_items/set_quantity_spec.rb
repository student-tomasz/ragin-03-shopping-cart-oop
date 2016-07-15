module Shop
  module Services
    module CartItems
      RSpec.describe SetQuantity do
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

          shared_examples 'raises ProductDoesNotExistError' do |product_id|
            it 'raises ProductDoesNotExistError' do
              attrs = { product_id: product_id, quantity: 1 }
              expect { SetQuantity.new.call(attrs) }
                .to raise_error(SetQuantity::ProductDoesNotExistError)
            end
          end

          shared_examples 'raises InvalidQuantityError' do |quantity|
            it 'raises InvalidQuantityError' do
              attrs = { product_id: book.id, quantity: quantity }
              expect { SetQuantity.new.call(attrs) }
                .to raise_error(SetQuantity::InvalidQuantityError)
            end
          end

          context 'with a nil id' do
            include_examples 'raises ProductDoesNotExistError', nil
          end

          context 'with an unknown id' do
            include_examples 'raises ProductDoesNotExistError', -1
          end

          context 'with a nil quantity' do
            include_examples 'raises InvalidQuantityError', nil
          end

          context 'with a non-Numeric quantity' do
            include_examples 'raises InvalidQuantityError', 'asd'
          end

          context 'with a non-Integer quantity' do
            include_examples 'raises InvalidQuantityError', 13.7
          end

          context 'with a negative quantity' do
            include_examples 'raises InvalidQuantityError', -1
          end

          context 'with valid id' do
            it 'sets the Models::CartItem#quantity' do
              expect { SetQuantity.new.call(product_id: book.id, quantity: 17) }
                .to change { Fetch.new.call(product_id: book.id).quantity }
                .from(1).to(17)
            end
          end
        end
      end
    end
  end
end
