require 'lib/product'

RSpec.describe Product do
  subject(:product) do
    Product.new(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_category_id: 2
    )
  end

  it { is_expected.to be }

  it 'has an id' do
    expect(product.id).to eq(1)
  end

  it 'has a name' do
    expect(product.name).to eq('Agile Web Development with Rails 5')
  end

  it 'has a price' do
    expect(product.price).to eq(2800)
  end

  it 'has a price in cents' do
    expect(product.price).to be_an(Integer)
  end

  it 'has a vat' do
    expect(product.vat).to be(VAT.for_category(2).value)
  end

  it 'has a price with vat' do
    expect(product.price_with_vat).to eq(3024)
  end

  it 'has a price with vat in cents' do
    expect(product.price_with_vat).to be_an(Integer)
  end

  it 'is equivalent to a product with identical attrs' do
    identical_product = Product.new(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_category_id: 2
    )
    expect(product).to eq(identical_product)
    expect(product).to eql(identical_product)
    expect(product).not_to equal(identical_product)
  end

  it 'produces corrent hash' do
    expected_hash = {
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      price_with_vat: 3024,
      vat: 0.08
    }
    expect(product.to_h).to eq(expected_hash)
  end
end
