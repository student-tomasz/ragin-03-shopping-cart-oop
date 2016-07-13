RSpec.describe Shop::Presenters::Cart do
  context 'with nil cart' do
    describe '#new' do
      let(:cart) { nil }

      it 'raises error' do
        expect { Shop::Presenters::Cart.new(nil) }
          .to raise_error(Shop::Presenters::Cart::InvalidCartError)
      end
    end
  end

  context 'with valid cart' do
    let(:cart) { Shop::Models::Cart.new(Shop::CART) }

    subject(:cart_presenter) { Shop::Presenters::Cart.new(cart) }

    describe '#cart' do
      it 'is a Models::Cart' do
        expect(cart_presenter.cart).to be_an(Shop::Models::Cart)
      end
    end

    describe '#items' do
      it 'is an array of Presenters::CartItem' do
        cart_presenter.items.each do |cart_item_presenter|
          expect(cart_item_presenter).to be_a(Shop::Presenters::CartItem)
        end
      end
    end

    describe '#total' do
      it 'returns a formatted total' do
        expect(cart_presenter.total).to eq('$732.00')
      end
    end

    describe '#total_with_vat' do
      it 'returns a formatted total with vat' do
        expect(cart_presenter.total_with_vat).to eq('$793.26')
      end
    end
  end
end
