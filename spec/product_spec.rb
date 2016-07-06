require_relative '../product'

RSpec.describe Product do
  subject(:product) do Product.new(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_category_id: 2
    )
  end

  it { is_expected.to be }

  it do
    is_expected.to have_attributes(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_category_id: 2
    )
  end

  it 'has a price attr in cents' do
    expect(product.price).to be_an(Integer)
  end

  it 'is an equivalent to a product with identical attrs' do
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
end
