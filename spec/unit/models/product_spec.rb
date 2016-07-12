RSpec.describe Shop::Models::Product do
  let(:params) do
    {
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_id: 2
    }
  end

  subject(:product) { Shop::Models::Product.new(params) }

  describe '#new' do
    shared_examples 'raises error' do |error_type|
      it "raises #{error_type.name.split('::').last}" do
        expect { Shop::Models::Product.new(invalid_params) }
          .to raise_error(error_type)
      end
    end

    context "with invalid name that's" do
      context 'nil' do
        let(:invalid_params) { params.merge!(name: nil) }

        include_examples 'raises error', Shop::Models::Product::InvalidNameError
      end

      context 'not a string' do
        let(:invalid_params) { params.merge!(name: 1234) }

        include_examples 'raises error', Shop::Models::Product::InvalidNameError
      end

      context 'shorter than 2 characters' do
        let(:invalid_params) { params.merge!(name: 'a') }

        include_examples 'raises error', Shop::Models::Product::InvalidNameError
      end
    end

    context "with invalid price that's" do
      context 'not an integer' do
        let(:invalid_params) { params.merge!(price: 12.34) }

        include_examples 'raises error', Shop::Models::Product::InvalidPriceError
      end

      context 'not a positive number' do
        let(:invalid_params) { params.merge!(price: -1200) }

        include_examples 'raises error', Shop::Models::Product::InvalidPriceError
      end
    end

    context 'with invalid vat' do
      context 'nil' do
        let(:invalid_params) { params.merge!(vat_id: nil) }

        include_examples 'raises error', Shop::Models::VAT::UnknownCategoryError
      end

      context 'unknown category' do
        let(:invalid_params) { params.merge!(vat_id: -1) }

        include_examples 'raises error', Shop::Models::VAT::UnknownCategoryError
      end
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

  describe 'equality using' do
    let(:other_product) { Shop::Models::Product.new(params.merge!(id: product.id)) }

    describe '#==' do
      context 'with other product of the same id' do
        it 'returns true' do
          expect(product == other_product).to be true
        end
      end
    end

    describe '#eql?' do
      context 'with other product of the same id' do
        it 'returns true' do
          expect(product.eql?(other_product)).to be true
        end
      end
    end

    describe '#equal?' do
      context 'with other product of the same id' do
        it 'returns false' do
          expect(product.equal?(other_product)).to be false
        end
      end
    end
  end

  describe '#to_h' do
    let(:expected_hash) do
      {
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        price_with_vat: 3024,
        vat: 0.08
      }
    end

    it 'returns a filled hash' do
      expect(product.to_h).to include(:id)
      expect(product.to_h).to include(expected_hash)
    end
  end
end
