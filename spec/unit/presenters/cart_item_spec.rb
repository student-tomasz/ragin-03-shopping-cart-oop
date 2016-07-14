RSpec.describe Shop::Presenters::CartItem do
  context 'with nil cart item' do
    let(:cart_item) { nil }

    describe '#new' do
      it 'raises error' do
        expect { Shop::Presenters::CartItem.new(cart_item) }
          .to raise_error(Shop::Presenters::CartItem::InvalidCartItemError)
      end
    end
  end

  context 'with cart item of two tshirts' do
    let(:tshirt) do
      Shop::Models::Product.new(
        id: 6,
        name: 'Pragmatic T-Shirt',
        price: 900,
        vat_id: 1
      )
    end

    before do
      allow(Shop).to receive(:PRODUCTS).and_return([tshirt])
    end

    let(:cart_item) do
      Shop::Models::CartItem.new(product_id: tshirt.id, quantity: 2)
    end

    subject(:cart_item_presenter) { Shop::Presenters::CartItem.new(cart_item) }

    describe '#cart_item' do
      it 'is a Models::CartItem' do
        expect(cart_item_presenter.cart_item).to be_a(Shop::Models::CartItem)
      end
    end

    describe '#product' do
      it 'is a Presenters::Product' do
        expect(cart_item_presenter.product).to be_a(Shop::Presenters::Product)
      end
    end

    describe '#total' do
      it 'returns a formatted total' do
        expect(cart_item_presenter.total).to eq('$18.00')
      end
    end

    describe '#total_with_vat' do
      it 'returns a formatted total with vat' do
        expect(cart_item_presenter.total_with_vat).to eq('$22.14')
      end
    end
  end
end
