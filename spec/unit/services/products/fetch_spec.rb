module Shop
  module Services
    module Products
      RSpec.describe Fetch do
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

          shared_examples 'raises Products::ProductDoesNotExistError' do |product_id|
            it 'raises Products::ProductDoesNotExistError' do
              expect { Fetch.new.call(product_id: product_id) }
                .to raise_error(Products::ProductDoesNotExistError)
            end
          end

          context 'with a nil id' do
            include_examples 'raises Products::ProductDoesNotExistError', nil
          end

          context "with a non-existant Product's id" do
            include_examples 'raises Products::ProductDoesNotExistError', nil
          end

          context 'with valid id' do
            it 'returns the Models::Product requested' do
              expect(Fetch.new.call(product_id: book.id))
                .to eq(book)
            end
          end
        end
      end
    end
  end
end
