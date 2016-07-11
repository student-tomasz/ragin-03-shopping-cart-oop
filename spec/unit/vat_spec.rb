require 'lib/vat'

VALID_CATEGORY_ID = 1
INVALID_CATEGORY_ID = 13
NIL_CATEGORY_ID = 0

RSpec.describe Shop::VAT do
  it 'cannot be created' do
    expect { Shop::VAT.new }.to raise_error(NoMethodError)
  end

  context 'when asked for valid category' do
    subject(:vat) { Shop::VAT.for_category(VALID_CATEGORY_ID) }

    it 'returns a VAT' do
      expect(vat).to be
    end

    it 'returns a VAT with value' do
      expect(vat.value).to eq(0.23)
    end

    it 'returns a VAT that is a Float' do
      expect(vat.value).to be_a(Float)
    end
  end

  context 'when asked for invalid category' do
    subject(:vat) { Shop::VAT.for_category(INVALID_CATEGORY_ID) }

    it 'still returns a VAT' do
      expect(vat).to be
    end

    it 'returns a nil VAT' do
      expect(vat).to eq(Shop::VAT.for_category(NIL_CATEGORY_ID))
    end
  end
end
