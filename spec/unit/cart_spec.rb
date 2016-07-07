require 'lib/cart'

RSpec.describe Cart do
  let(:book_id) { 3 }
  let(:shirt_id) { 6 }

  context 'when empty' do
    subject(:cart) { Cart.new }

    it 'has zero total' do
      expect(cart.total).to eq(0)
    end

    it 'has zero total with vat' do
      expect(cart.total_with_vat).to eq(0)
    end

    it 'has no items' do
      expect(cart.items).to be_empty
    end

    it 'has an zeroed hash' do
      expected_hash = {
        items: [],
        total: 0,
        total_with_vat: 0
      }
      expect(cart.to_h).to eq(expected_hash)
    end
  end

  context 'with a book and a doubled t-shirt' do
    subject(:cart) do
      cart = Cart.new
      [book_id, shirt_id, shirt_id].each { |product_id| cart.add(product_id) }
      cart
    end

    it 'contains two unique items' do
      expect(cart.items.length).to eq(2)
    end

    it 'has a non-zero total' do
      expect(cart.total).to eq(4200)
    end

    it 'has a total in cents' do
      expect(cart.total).to be_an(Integer)
    end

    it 'has a non-zero total with vat' do
      expect(cart.total_with_vat).to eq(4806)
    end

    it 'has a total with vat in cents' do
      expect(cart.total_with_vat).to be_an(Integer)
    end

    context 'after removing one t-shirt' do
      subject(:one_shirt_cart) do
        cart.remove(shirt_id)
        cart
      end

      it 'still contains two unique items' do
        expect(one_shirt_cart.items.length).to eq(2)
      end

      it 'has a lower total' do
        expect(one_shirt_cart.total).to eq(3300)
      end

      it 'has a lower total with vat' do
        expect(one_shirt_cart.total_with_vat).to eq(3699)
      end

      context 'after removing another t-shirt' do
        subject(:shirtless_cart) do
          one_shirt_cart.remove(shirt_id)
          one_shirt_cart
        end

        it 'contains one unique item' do
          expect(shirtless_cart.items.length).to eq(1)
        end

        it 'has a total equal to the book\' price' do
          expect(shirtless_cart.total).to eq(2400)
        end

        it 'has a total with vat equal to the book\' price with vat' do
          expect(shirtless_cart.total_with_vat).to eq(2592)
        end
      end
    end
  end
end
