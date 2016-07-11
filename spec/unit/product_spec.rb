require_relative '../../lib/product'

RSpec.describe Shop::Product do
  let(:attributes) do
    {
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_category_id: 2
    }
  end

  subject(:product) { Shop::Product.new(attributes) }

  it { is_expected.to be } # the bestests test

  describe '#new' do
    it 'requires an id' do
      attributes[:id] = nil
      expect { Shop::Product.new(attributes) }.to raise_error(ArgumentError)
    end

    it 'requires a name' do
      attributes[:name] = nil
      expect { Shop::Product.new(attributes) }.to raise_error(ArgumentError)
    end

    it 'requires a name to be a string' do
      attributes[:name] = 3
      expect { Shop::Product.new(attributes) }.to raise_error(ArgumentError)
    end

    it 'requires a name to be at least 2 characters long' do
      attributes[:name] = 3
      expect { Shop::Product.new(attributes) }.to raise_error(ArgumentError)
    end

    it 'requires a price to be an integer' do
      attributes[:price] = 12.34
      expect { Shop::Product.new(attributes) }.to raise_error(ArgumentError)
    end

    it 'requires a price to be positive number' do
      attributes[:price] = -12
      expect { Shop::Product.new(attributes) }.to raise_error(ArgumentError)
    end

    it 'requires a vat category id to be exactly either 1 or 2' do
      attributes[:vat_category_id] = 1
      expect { Shop::Product.new(attributes) }.not_to raise_error
      attributes[:vat_category_id] = 2
      expect { Shop::Product.new(attributes) }.not_to raise_error
      attributes[:vat_category_id] = 3
      expect { Shop::Product.new(attributes) }.to raise_error(ArgumentError)
    end
  end

  describe '#id' do
    subject { product.id }

    it { is_expected.not_to be_nil }
  end

  describe '#name' do
    subject { product.name }

    it { is_expected.not_to be_nil }
    it { is_expected.to be_a(String) }
    it { is_expected.not_to be_empty }
  end

  describe '#price' do
    subject { product.price }

    it { is_expected.not_to be_nil }
    it { is_expected.to be_a(Integer) }
    it { is_expected.to eq(2800) }
  end

  describe '#price_with_vat' do
    subject { product.price_with_vat }

    it { is_expected.not_to be_nil }
    it { is_expected.to be_a(Integer) }
    it { is_expected.to eq(3024) }
  end

  describe '#vat' do
    subject { product.vat }

    it { is_expected.not_to be_nil }
    it { is_expected.to be_a(Float) }
    it { is_expected.to eq(0.08) }
  end

  describe '#eql?' do
    it 'returns true for an identical product' do
      identical_product = Shop::Product.new(
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

  describe '#to_h' do
    it 'returns a filled hash' do
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
end
