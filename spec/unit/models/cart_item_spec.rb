RSpec.describe Shop::Models::CartItem do
  let(:product) do
    Shop::Models::Product.new(
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_id: 2
    )
  end

  before :each do
    # allow(Shop).to receive(:PRODUCTS).and_return([product])
    stub_const('Shop::PRODUCTS', [product])
  end

  shared_examples 'returns a multiplied' do |method, quantity|
    it "returns the product's #{method} multiplied times #{quantity}" do
      expect(subject).to eq(product.send(method) * quantity)
    end

    it 'is an integer' do
      expect(subject).to be_an(Integer)
    end
  end

  describe '#new' do
    context 'when product_id is' do
      context 'nil' do
        it 'raises error' do
          expect { Shop::Models::CartItem.new(product_id: nil) }
            .to raise_error(Shop::Models::CartItem::InvalidProductIdError)
        end
      end

      context 'unknown' do
        it 'raises error' do
          expect { Shop::Models::CartItem.new(product_id: -1) }
            .to raise_error(Shop::Models::CartItem::InvalidProductIdError)
        end
      end
    end

    context 'when quantity is' do
      context 'nil' do
        it 'raises error' do
          expect { Shop::Models::CartItem.new(product_id: product.id, quantity: nil) }
            .to raise_error(Shop::Models::CartItem::InvalidQuantityError)
        end
      end

      context 'negative' do
        it 'raises error' do
          expect { Shop::Models::CartItem.new(product_id: product.id, quantity: -1) }
            .to raise_error(Shop::Models::CartItem::InvalidQuantityError)
        end
      end

      context 'not an integer' do
        it 'raises error' do
          expect { Shop::Models::CartItem.new(product_id: product.id, quantity: 'asd') }
            .to raise_error(Shop::Models::CartItem::InvalidQuantityError)
        end
      end
    end
  end

  context 'when valid' do
    subject(:item) { Shop::Models::CartItem.new(product_id: product.id) }

    describe '#product' do
      it 'returns the passed product' do
        expect(item.product).to eq(product)
      end
    end

    describe '#quantity' do
      subject(:quantity) { item.quantity }

      it { is_expected.to eq(0) }
      it { is_expected.to be_an(Integer) }
    end

    describe '#total' do
      subject(:total) { item.total }

      include_examples 'returns a multiplied', :price, 0
    end

    describe '#total_with_vat' do
      subject(:total_with_vat) { item.total_with_vat }

      include_examples 'returns a multiplied', :price_with_vat, 0
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
  end

  context 'when valid and with quantity of 2' do
    subject(:incremented_item) do
      Shop::Models::CartItem.new(product_id: product.id, quantity: 2)
    end

    describe '#product' do
      it 'returns the passed product' do
        expect(incremented_item.product).to eq(product)
      end
    end

    describe '#quantity' do
      subject(:quantity) { incremented_item.quantity }

      it { is_expected.to eq(2) }
      it { is_expected.to be_an(Integer) }
    end

    describe '#total' do
      subject(:total) { incremented_item.total }

      include_examples 'returns a multiplied', :price, 2
    end

    describe '#total_with_vat' do
      subject(:total_with_vat) { incremented_item.total_with_vat }

      include_examples 'returns a multiplied', :price_with_vat, 2
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
