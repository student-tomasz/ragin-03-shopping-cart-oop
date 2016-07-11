require_relative '../../lib/inventory_item'
require_relative '../../lib/product'

RSpec.describe Shop::InventoryItem do
  it 'requires a product' do
    expect { Shop::InventoryItem.new(nil) }.to raise_error(ArgumentError)
  end

  context 'when created for a valid product' do
    let(:product) do
      Shop::Product.new(
        id: 1,
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        vat_id: 2
      )
    end

    subject(:item) { Shop::InventoryItem.new(product) }

    describe '#new' do
      it 'accepts an optional quantity' do
        expect { Shop::InventoryItem.new(product, 1) }
          .not_to raise_error
      end

      it 'requires a not-nil quantity' do
        expect { Shop::InventoryItem.new(product, nil) }
          .to raise_error(ArgumentError)
      end

      it 'requires an integer quantity' do
        expect { Shop::InventoryItem.new(product, 'a') }
          .to raise_error(ArgumentError)
        expect { Shop::InventoryItem.new(product, 1.2) }
          .to raise_error(ArgumentError)
      end

      it 'requires a quantity > 0' do
        expect { Shop::InventoryItem.new(product, -1) }
          .to raise_error(ArgumentError)
        expect { Shop::InventoryItem.new(product, 0) }
          .not_to raise_error
      end
    end

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

    describe '#to_h' do
      it 'returns a zeroed hash' do
        expect(item.to_h).to include(:product)
        expect(item.to_h).to include(quantity: 0)
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

      describe '#to_h' do
        it 'returns a filled hash' do
          expect(incremented_item.to_h).to include(:product)
          expect(incremented_item.to_h).to include(quantity: 2)
        end
      end
    end
  end
end
