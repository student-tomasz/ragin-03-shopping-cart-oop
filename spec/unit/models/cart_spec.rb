RSpec.describe Shop::Models::Cart do
  describe '#new' do
    context 'with nil' do
      it 'raises an error' do
        expect { Shop::Models::Cart.new(nil) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with an array containing anything other than Models::CartItem' do
      it 'raises an error' do
        expect { Shop::Models::Cart.new([Object.new]) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with an empty array' do
      it 'doesn\'t raise an error' do
        expect { Shop::Models::Cart.new([]) }
          .not_to raise_error
      end
    end
  end
  shared_examples 'returns a sum of' do |method, value|
    it "sums items' #{method}" do
      expect(subject.send(method)).to eq(value)
    end

    it 'is an integer' do
      expect(subject.send(method)).to be_an(Integer)
    end
  end

  context 'when empty' do
    subject(:cart) do
      Shop::Models::Cart.new([])
    end

    describe '#items' do
      it 'is empty' do
        expect(cart.items).to be_empty
      end
    end

    describe '#total' do
      include_examples 'returns a sum of', :total, 0
    end

    describe '#total_with_vat' do
      include_examples 'returns a sum of', :total_with_vat, 0
    end

    describe '#to_h' do
      let(:expected_hash) do
        {
          items: [],
          total: 0,
          total_with_vat: 0
        }
      end

      it 'returns zeroed hash' do
        expect(cart.to_h).to eq(expected_hash)
      end
    end
  end

  context 'with a book and a doubled t-shirt' do
    subject(:cart) do
      cart_items = [
        Shop::Models::CartItem.new(product_id: 3, quantity: 1),
        Shop::Models::CartItem.new(product_id: 6, quantity: 2)
      ]
      Shop::Models::Cart.new(cart_items)
    end

    describe '#items' do
      it 'contains 2 items' do
        expect(cart.items.length).to eq(2)
      end

      it 'contains only unique items' do
        expect(cart.items.uniq.length).to eq(2)
      end
    end

    describe '#total' do
      include_examples 'returns a sum of', :total, 4200
    end

    describe '#total_with_vat' do
      include_examples 'returns a sum of', :total_with_vat, 4806
    end
  end
end
