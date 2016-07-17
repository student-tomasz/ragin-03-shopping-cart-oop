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
    let(:book) do
      Shop::Models::Product.new(
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        vat_id: 2
      )
    end

    let(:tshirt) do
      Shop::Models::Product.new(
        name: 'Pragmatic T-Shirt',
        price: 900,
        vat_id: 1
      )
    end

    before :each do
      stub_const('Shop::PRODUCTS', [book, tshirt])
    end

    let(:cart_items) do
      [
        Shop::Models::CartItem.new(product_id: book.id, quantity: 1),
        Shop::Models::CartItem.new(product_id: tshirt.id, quantity: 2)
      ]
    end

    let(:cart) { Shop::Models::Cart.new(cart_items) }

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
        expect(cart_presenter.total).to eq('$46.00')
      end
    end

    describe '#total_with_vat' do
      it 'returns a formatted total with vat' do
        expect(cart_presenter.total_with_vat).to eq('$52.38')
      end
    end
  end
end
