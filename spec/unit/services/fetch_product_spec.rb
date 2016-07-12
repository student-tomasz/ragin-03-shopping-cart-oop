RSpec.describe Shop::Services::FetchProduct do
  let(:product) do
    Shop::Models::Product.new(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_id: 2
    )
  end

  describe '#call' do
    context 'with invalid id' do
      let(:invalid_product_id) { -1 }

      it 'returns nil' do
        stub_const('Shop::PRODUCTS', [product])
        expect(Shop::Services::FetchProduct.new.call(invalid_product_id))
          .to be nil
      end
    end

    context 'with valid id' do
      let(:product_id) { 1 }

      it 'returns a Product' do
        stub_const('Shop::PRODUCTS', [product])
        expect(Shop::Services::FetchProduct.new.call(product_id))
          .to be_a(Shop::Models::Product)
      end

      it 'returns the product' do
        stub_const('Shop::PRODUCTS', [product])
        expect(Shop::Services::FetchProduct.new.call(product_id))
          .to eq(product)
      end
    end
  end
end
