RSpec.describe Shop::Services::FetchProduct do
  describe '#call' do
    let(:book) do
      Shop::Models::Product.new(
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        vat_id: 2
      )
    end

    context 'with invalid id' do
      before :each do
        stub_const('Shop::PRODUCTS', [])
      end

      it 'returns nil' do
        expect(Shop::Services::FetchProduct.new.call(product_id: book.id))
          .to be nil
      end
    end

    context 'with valid id' do
      before :each do
        stub_const('Shop::PRODUCTS', [book])
      end

      it 'returns a Product' do
        expect(Shop::Services::FetchProduct.new.call(product_id: book.id))
          .to be_a(Shop::Models::Product)
      end

      it 'returns the product' do
        expect(Shop::Services::FetchProduct.new.call(product_id: book.id))
          .to eq(book)
      end
    end
  end
end
