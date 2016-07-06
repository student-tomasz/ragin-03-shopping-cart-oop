require_relative '../catalog'
require_relative '../product'

RSpec.describe Catalog do
  context 'when asked for existing product' do
    let(:product_id) { 1 }

    it 'confirms the product exists' do
      expect(Catalog.has?(product_id)).to be_truthy
    end

    it 'returns a product' do
      expect(Catalog.find(product_id)).to be_a(Product)
    end

    it 'returns the product' do
      identical_product = Product.new(
        id: 1,
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        vat_category_id: 2
      )
      expect(Catalog.find(product_id)).to eq(identical_product)
    end
  end

  context 'when asked for non-existing product' do
    let(:product_id) { -1 }

    it 'denies the product exists' do
      expect(Catalog.has?(product_id)).to be_falsey
    end

    it 'returns nil' do
      expect(Catalog.find(product_id)).to be_nil
    end
  end
end
