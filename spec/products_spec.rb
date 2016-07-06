require_relative '../product'
require_relative '../products'

RSpec.describe Products do
  context 'when asked for existing product' do
    it 'returns the product' do
      identical_product = Product.new(
        id: 1,
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        vat_category_id: 2
      )
      expect(Products.find(1)).to eq(identical_product)
    end
  end

  context 'when asked for non-existing product' do
    it 'raises error' do
      expect { Products.find(-1) }.to raise_error ArgumentError
    end
  end
end
