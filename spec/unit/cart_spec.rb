require 'lib/cart'
require 'lib/inventory'
require 'lib/product'

RSpec.describe Cart do
  let(:no_book) do
    Product.new(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_category_id: 2
    )
  end

  let(:book) do
    Product.new(
      id: 3,
      name: 'Web Development with Clojure, Second Edition',
      price: 2400,
      vat_category_id: 2
    )
  end

  let(:shirt) do
    Product.new(
      id: 6,
      name: 'Pragmatic T-Shirt',
      price: 900,
      vat_category_id: 1
    )
  end

  let(:not_in_offer_book) do
    Product.new(
      id: 1234,
      name: 'Harry Potter and the Goblet of Fire',
      price: 1900,
      vat_category_id: 2
    )
  end

  let(:catalog) { [no_book, book, shirt] }
  let(:quantities) { { no_book.id => 0, book.id => 1, shirt.id => 2 } }
  let(:inventory) { Inventory.new(catalog, quantities) }

  subject(:cart) { Cart.new(inventory) }

  describe '#add' do
    it 'raises error for nil' do
      expect { cart.add(nil) }.to raise_error(ArgumentError)
    end

    it 'raises error for a product not in offer' do
      expect { cart.add(not_in_offer_book) }.to raise_error(ArgumentError)
    end

    context 'when asked for an available product' do
      it 'returns its new quantity' do
        expect(cart.add(book)).to eq(1)
      end

      it 'increments its quantity by 1' do
        expect(cart.add(book)).to eq(1)
        expect(cart.add(shirt)).to eq(1)
        expect(cart.add(shirt)).to eq(2)
      end
    end

    context 'when asked for an unavailable product' do
      it 'returns nil' do
        expect(cart.add(no_book)).to be_nil
        expect(cart.add(book)).to eq(1)
        expect(cart.add(book)).to be_nil
      end
    end
  end

  describe '#remove' do
    it 'raises error for nil' do
      expect { cart.remove(nil) }.to raise_error(ArgumentError)
    end

    it 'raises error when product not in cart' do
      expect { cart.remove(shirt) }.to raise_error(ArgumentError)
    end

    it 'returns new quantity of the product' do
      cart.add(book)
      expect(cart.remove(book)).to eq(0)
    end

    it 'decrements quantity of the product by 1' do
      cart.add(shirt)
      cart.add(shirt)
      expect(cart.remove(shirt)).to eq(1)
      expect(cart.remove(shirt)).to eq(0)
    end

    it 'forgets about the product when decremented to 0' do
      cart.add(book)
      cart.remove(book)
      expect(cart.items).not_to include(book)
    end
  end

  context 'when empty' do
    subject(:cart) { Cart.new(Inventory.new([])) }

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
      cart = Cart.new(inventory)
      [book, shirt, shirt].each { |product| cart.add(product) }
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
        cart.remove(shirt)
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
          one_shirt_cart.remove(shirt)
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
