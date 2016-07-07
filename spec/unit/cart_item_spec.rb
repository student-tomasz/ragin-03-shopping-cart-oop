require 'lib/cart_item'

RSpec.describe CartItem do
  context 'when created for an invalid product' do
    let(:product_id) { -1 }

    it 'raises error' do
      expect { CartItem.new(product_id) }.to raise_error(ArgumentError)
    end
  end

  context 'when created for a valid product' do
    let(:product_id) { 1 }

    subject(:item) { CartItem.new(product_id) }

    it 'contains the passed product id' do
      expect(item.product_id).to eq(product_id)
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

    it 'exports to a hash' do
      expect(item.to_h).to eq(
        product: {
          id: 1,
          name: 'Agile Web Development with Rails 5',
          price: 2800,
          price_with_vat: 3024,
          vat: 0.08
        },
        quantity: 0,
        total: 0,
        total_with_vat: 0
      )
    end

    context 'when twice incremented' do
      subject(:incremented_item) do
        item.increment
        item.increment
        item
      end

      it 'has quantity value of two' do
        expect(incremented_item.quantity).to eq(2)
      end

      it 'decrements quantity by one at a time' do
        expect { incremented_item.decrement }
          .to change { incremented_item.quantity }
          .from(2)
          .to(1)
      end

      it 'has a total of exactly two books\' price' do
        expect(incremented_item.total).to eq(5600)
      end

      it 'has a total with vat of exactly two books\' price with vat' do
        expect(incremented_item.total_with_vat).to eq(6048)
      end

      it 'exports to an updated hash' do
        expect(incremented_item.to_h).to eq(
          product: {
            id: 1,
            name: 'Agile Web Development with Rails 5',
            price: 2800,
            price_with_vat: 3024,
            vat: 0.08
          },
          quantity: 2,
          total: 5600,
          total_with_vat: 6048
        )
      end
    end
  end
end
