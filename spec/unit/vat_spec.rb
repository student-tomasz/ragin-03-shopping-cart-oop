require_relative '../../lib/vat'

RSpec.describe Shop::VAT do
  let(:valid_id) { 1 }
  let(:invalid_id) { -1 }

  it 'cannot be created' do
    expect { Shop::VAT.new }.to raise_error(NoMethodError)
  end

  describe '.for_category' do
    context 'with valid id' do
      subject(:vat) { Shop::VAT.for_category(valid_id) }

      it 'returns a VAT' do
        expect(vat).to be_a(Shop::VAT)
      end

      it 'returns a VAT with correct value' do
        expect(vat.value).to eq(0.23)
      end
    end

    context 'with invalid id' do
      it 'raises error' do
        expect { Shop::VAT.for_category(invalid_id) }
          .to raise_error Shop::VAT::UnknownCategoryError
      end
    end

    it 'returns the same instance of VAT' do
      expect(Shop::VAT.for_category(1)).to eql(Shop::VAT.for_category(1))
    end
  end
end
