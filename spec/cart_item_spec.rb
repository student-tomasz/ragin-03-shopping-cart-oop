require_relative '../cart_item'

INVALID_PRODUCT_ID = -1
VALID_PRODUCT_ID = 1
VALID_PRODUCT_HASH = {
  id: 1,
  name: 'Agile Web Development with Rails 5',
  price: 2800,
  price_with_vat: 3024,
  vat: 0.08
}

RSpec.describe CartItem do
  it 'raises error when created for invalid product' do
    expect { CartItem.new INVALID_PRODUCT_ID }.to raise_error(ArgumentError)
  end

  context 'when created for a valid product' do
    subject(:item) { CartItem.new VALID_PRODUCT_ID }

    it 'contains the passed product' do
      expect(item.product.id).to eq(VALID_PRODUCT_ID)
    end

    it 'has zero quantity' do
      expect(item.quantity).to eq(0)
    end

    it 'increments quantity by one at a time' do
      expect { item.increment }. to change { item.quantity }.from(0).to(1)
    end

    it 'doesn\'t decrement below zero' do
      expect { item.decrement }.not_to change { item.quantity }
    end

    it 'has a total of zero' do
      expect(item.total).to eq(0)
    end

    it 'has a total that is an integer' do
      expect(item.total).to be_an(Integer)
    end

    it 'has a total with vat of zero' do
      expect(item.total_with_vat).to eq(0)
    end

    it 'has a total with vat that is an integer' do
      expect(item.total_with_vat).to be_an(Integer)
    end

    it 'returns correct hash' do
      expect(item.to_h).to eq(
        product: VALID_PRODUCT_HASH,
        quantity: 0,
        total: 0,
        total_with_vat: 0
      )
    end

    context 'when twice incremented' do
      subject(:item) do
        item = CartItem.new VALID_PRODUCT_ID
        item.increment
        item.increment
        item
      end

      it 'has quantity value of two' do
        expect(item.quantity).to eq(2)
      end

      it 'decrements quantity by one at a time' do
        expect { item.decrement }. to change { item.quantity }.from(2).to(1)
      end

      it 'has a total of exactly two books\' price' do
        expect(item.total).to eq(5600)
      end

      it 'has a total with vat of exactly two books\' price with vat' do
        expect(item.total_with_vat).to eq(6048)
      end

      it 'returns updated hash' do
        expect(item.to_h).to eq(
          product: VALID_PRODUCT_HASH,
          quantity: 2,
          total: 5600,
          total_with_vat: 6048
        )
      end
    end
  end
end
