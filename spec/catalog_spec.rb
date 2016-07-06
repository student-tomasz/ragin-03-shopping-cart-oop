require_relative '../catalog'
require_relative '../product'

VALID_PRODUCT_ID = 1
INVALID_PRODUCT_ID = -1

RSpec.describe Catalog do
  context 'when asked for existing product' do
    it 'confirms the product exists' do
      expect(Catalog.has?(VALID_PRODUCT_ID)).to be_truthy
    end

    it 'returns a product' do
      expect(Catalog.find(1)).to be_a(Product)
    end

    it 'returns the product' do
      identical_product = Product.new(
        id: 1,
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        vat_category_id: 2
      )
      expect(Catalog.find(VALID_PRODUCT_ID)).to eq(identical_product)
    end
  end

  context 'when asked for non-existing product' do
    it 'denies the product exists' do
      expect(Catalog.has?(INVALID_PRODUCT_ID)).to be_falsey
    end

    it 'returns nil' do
      expect(Catalog.find(INVALID_PRODUCT_ID)).to be_nil
    end
  end
end
