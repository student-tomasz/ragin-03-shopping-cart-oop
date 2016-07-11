require_relative '../../lib/cart_item'
require_relative '../../lib/product'

RSpec.describe Shop::CartItem do
  context 'when created for an invalid product' do
    it 'raises error' do
      expect { Shop::CartItem.new(nil) }.to raise_error(ArgumentError)
    end
  end

  context 'when created for a valid product' do
    let(:product) do
      Shop::Product.new(
        id: 1,
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        vat_category_id: 2
      )
    end

    subject(:item) { Shop::CartItem.new(product) }

    describe '#product' do
      it 'returns the passed product' do
        expect(item.product).to eq(product)
      end
    end

    describe '#quantity' do
      it 'returns 0' do
        expect(item.quantity).to eq(0)
      end
    end

    describe '#increment' do
      it 'increments by 1 to a quantity of 1' do
        expect { item.increment }
          .to change { item.quantity }.from(0).to(1)
      end
    end

    describe '#decrement' do
      it 'doesn\'t decrement below 0' do
        expect { item.decrement }
          .not_to change { item.quantity }
      end
    end

    describe '#total' do
      it 'returns 0' do
        expect(item.total).to eq(0)
      end

      it 'is an integer' do
        expect(item.total).to be_an(Integer)
      end
    end

    describe '#total_with_vat' do
      it 'returns 0' do
        expect(item.total_with_vat).to eq(0)
      end

      it 'is an integer' do
        expect(item.total_with_vat).to be_an(Integer)
      end
    end

    describe '#to_h' do
      it 'returns a zeroed hash' do
        expect(item.to_h).to include(:product)
        expect(item.to_h).to include(
          quantity: 0,
          total: 0,
          total_with_vat: 0
        )
      end
    end

    context 'when twice incremented' do
      subject(:incremented_item) do
        item.increment
        item.increment
        item
      end

      describe '#product' do
        it 'returns the passed product' do
          expect(incremented_item.product).to eq(product)
        end
      end

      describe '#increment' do
        it 'increments by 1 to a quantity of 3' do
          expect { incremented_item.increment }
            .to change { incremented_item.quantity }
            .from(2)
            .to(3)
        end
      end

      describe '#decrement' do
        it 'decrements by 1 to a quantity of 1' do
          expect { incremented_item.decrement }
            .to change { incremented_item.quantity }
            .from(2)
            .to(1)
        end
      end

      describe '#quantity' do
        it 'returns 2' do
          expect(incremented_item.quantity).to eq(2)
        end
      end

      describe '#total' do
        it 'returns doubled item\'s price' do
          expect(incremented_item.total).to eq(5600)
        end

        it 'is an integer' do
          expect(incremented_item.total).to be_an(Integer)
        end
      end

      describe '#total_with_vat' do
        it 'returns doubled item\' price with vat' do
          expect(incremented_item.total_with_vat).to eq(6048)
        end

        it 'is an integer' do
          expect(incremented_item.total_with_vat).to be_an(Integer)
        end
      end

      describe '#to_h' do
        it 'returns a filled hash' do
          expect(incremented_item.to_h).to include(:product)
          expect(incremented_item.to_h).to include(
            quantity: 2,
            total: 5600,
            total_with_vat: 6048
          )
        end
      end
    end
  end
end
