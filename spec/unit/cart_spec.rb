require_relative '../../lib/cart'
require_relative '../../lib/catalog'
require_relative '../../lib/inventory'
require_relative '../../lib/product'

RSpec.describe Shop::Cart do
  let(:unavailable_book) do
    Shop::Product.new(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_id: 2
    )
  end

  let(:available_book) do
    Shop::Product.new(
      id: 3,
      name: 'Web Development with Clojure, Second Edition',
      price: 2400,
      vat_id: 2
    )
  end

  let(:one_left_book) do
    Shop::Product.new(
      id: 5,
      name: 'Deploying with JRuby 9k',
      price: 1600,
      vat_id: 2
    )
  end

  let(:tshirt) do
    Shop::Product.new(
      id: 6,
      name: 'Pragmatic T-Shirt',
      price: 900,
      vat_id: 1
    )
  end

  let(:not_in_offer_book) do
    Shop::Product.new(
      id: 1234,
      name: 'Harry Potter and the Goblet of Fire',
      price: 1900,
      vat_id: 2
    )
  end

  let(:catalog) do
    Shop::Catalog.new([unavailable_book, available_book, one_left_book, tshirt])
  end

  let(:quantities) do
    {
      unavailable_book.id => 0,
      available_book.id => 19,
      one_left_book.id => 1,
      tshirt.id => 2
    }
  end

  let(:inventory) { Shop::Inventory.new(catalog, quantities) }

  subject(:cart) { Shop::Cart.new(inventory) }

  shared_examples 'increments quantity by 1' do |product_id|
    let(:product) { catalog.find(product_id) }

    it 'increments quantity by 1' do
      expect { subject.add(product) }
        .to change { subject.quantity(product) }.by(1)
    end
  end

  shared_examples 'decrements quantity by 1' do |product_id|
    let(:product) { catalog.find(product_id) }

    it 'decrements quantity by 1' do
      expect { subject.remove(product) }
        .to change { subject.quantity(product) }.by(-1)
    end
  end

  shared_examples 'doesn\'t change quantity' do |product_id|
    let(:product) { catalog.find(product_id) }

    it 'returns nil' do
      expect(subject.add(product)).to be_nil
    end

    it 'doesn\'t change quantity' do
      expect { subject.add(product) }
        .not_to change { subject.quantity(product) }
    end
  end

  describe '#add' do
    it 'raises error for nil' do
      expect { cart.add(nil) }.to raise_error(ArgumentError)
    end

    it 'raises error for a product not in offer' do
      expect { cart.add(not_in_offer_book) }.to raise_error(ArgumentError)
    end

    context 'when asked for an available product' do
      include_examples 'increments quantity by 1', 3 # available_book.id
    end

    context 'when asked for an unavailable product' do
      include_examples 'doesn\'t change quantity', 1 # unavailable_book.id
    end

    context 'when asked for a one left product' do
      include_examples 'increments quantity by 1', 5 # :one_left_book.id

      context 'when asked again' do
        subject(:cart_with_book) do
          cart.add(one_left_book)
          cart
        end

        include_examples 'doesn\'t change quantity', 5 # :one_left_book.id
      end
    end
  end

  describe '#remove' do
    subject(:filled_cart) do
      cart.add(one_left_book)
      cart.add(tshirt)
      cart.add(tshirt)
      cart
    end

    it 'raises error for nil' do
      expect { filled_cart.remove(nil) }.to raise_error(ArgumentError)
    end

    it 'raises error when product not in cart' do
      expect { filled_cart.remove(available_book) }.to raise_error(ArgumentError)
    end

    include_examples 'decrements quantity by 1', 6 # tshirt.id

    context 'when asked for one left product' do
      subject(:bookless_cart) { filled_cart.remove(one_left_book); filled_cart }

      it 'decrements quantity from 1 to 0' do
        expect { filled_cart.remove(one_left_book) }
          .to change { filled_cart.quantity(one_left_book) }.from(1).to(0)
      end

      it 'deletes the product' do
        expect(bookless_cart.items).not_to include(one_left_book)
      end
    end
  end

  context 'when empty' do
    subject(:cart) do
      empty_catalog = Shop::Catalog.new
      Shop::Cart.new(Shop::Inventory.new(empty_catalog))
    end

    describe '#items' do
      it 'is empty' do
        expect(cart.items).to be_empty
      end
    end

    describe '#total' do
      it 'returns 0' do
        expect(cart.total).to eq(0)
      end

      it 'is an integer' do
        expect(cart.total).to be_an(Integer)
      end
    end

    describe '#total_with_vat' do
      it 'returns 0' do
        expect(cart.total_with_vat).to eq(0)
      end

      it 'is an integer' do
        expect(cart.total_with_vat).to be_an(Integer)
      end
    end

    describe '#to_h' do
      it 'returns zeroed hash' do
        expected_hash = {
          items: [],
          total: 0,
          total_with_vat: 0
        }
        expect(cart.to_h).to eq(expected_hash)
      end
    end
  end

  context 'with a book and a doubled t-shirt' do
    subject(:cart) do
      cart = Shop::Cart.new(inventory)
      [available_book, tshirt, tshirt].each { |product| cart.add(product) }
      cart
    end

    describe '#items' do
      it 'contains two items' do
        expect(cart.items.uniq.length).to eq(2)
      end

      it 'contains unique items' do
        expect(cart.items.uniq.length).to eq(2)
      end
    end

    describe '#total' do
      it 'returns summed prices' do
        expect(cart.total).to eq(4200)
      end

      it 'is an integer' do
        expect(cart.total).to be_an(Integer)
      end
    end

    describe '#total_with_vat' do
      it 'returns summed prices with vat' do
        expect(cart.total_with_vat).to eq(4806)
      end

      it 'is an integer' do
        expect(cart.total_with_vat).to be_an(Integer)
      end
    end

    context 'with one t-shirt removed' do
      subject(:one_shirt_cart) do
        cart.remove(tshirt)
        cart
      end

      describe '#items' do
        it 'still contains two items' do
          expect(one_shirt_cart.items.length).to eq(2)
        end

        it 'still contains unique items' do
          expect(one_shirt_cart.items.length).to eq(2)
        end
      end

      describe '#total' do
        it 'returns total minus shirt\'s price' do
          expect(one_shirt_cart.total).to eq(3300)
        end
      end

      describe '#total_with_vat' do
        it 'returns total with vat minus shirt\'s price with vat' do
          expect(one_shirt_cart.total).to eq(3300)
        end
      end

      context 'with another shirt removed' do
        subject(:shirtless_cart) do
          one_shirt_cart.remove(tshirt)
          one_shirt_cart
        end

        describe '#items' do
          it 'contains one item' do
            expect(shirtless_cart.items.length).to eq(1)
          end
        end

        describe '#total' do
          it 'is equal to the book\' price' do
            expect(shirtless_cart.total).to eq(2400)
          end
        end

        describe '#total_with_vat' do
          it 'is equal to the book\' price with vat' do
            expect(shirtless_cart.total_with_vat).to eq(2592)
          end
        end
      end
    end
  end
end
