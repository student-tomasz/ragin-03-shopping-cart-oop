require 'lib/catalog'
require 'lib/inventory'

RSpec.describe Inventory do
  it 'requires z list of products' do
    expect { Inventory.new(nil) }.to raise_error(ArgumentError)
  end

  context 'when stocked with books only' do
    let(:quantities) { { 1 => 19, 2 => 8, 3 => 24, 4 => 1, 5 => 0 } }

    let(:shirt) { Catalog.find(6) }
    let(:books) { (1..5).to_a.map { |id| Catalog.find(id) } }
    let(:available_book) { books.select { |book| book.id == 1 }.first }
    let(:unavailable_book) { books.select { |book| book.id == 5 }.first }
    let(:one_left_book) { books.select { |book| book.id == 4 }.first }

    subject(:inventory) { Inventory.new(books, quantities) }

    describe '#quantity' do
      context 'when asked about a shirt' do
        it 'raises error' do
          expect { inventory.quantity(shirt) }.to raise_error(ArgumentError)
        end
      end

      context 'when asked about an available book ' do
        it 'returns > 0' do
          expect(inventory.quantity(available_book)).to be > 0
        end
      end

      context 'when asked about an unavailable book ' do
        it 'returns 0' do
          expect(inventory.quantity(unavailable_book)).to eq(0)
        end
      end
    end

    describe '#available?' do
      context 'when asked about a shirt' do
        it 'raises error' do
          expect { inventory.available?(shirt) }.to raise_error(ArgumentError)
        end
      end

      context 'when asked about an available book ' do
        it 'returns true' do
          expect(inventory.available?(available_book)).to be true
        end
      end

      context 'when asked about an unavailable book ' do
        it 'returns false' do
          expect(inventory.available?(unavailable_book)).to be false
        end
      end
    end

    describe '#reserve' do
      context 'when asked for a shirt' do
        it 'raises error' do
          expect { inventory.reserve(shirt) }.to raise_error(ArgumentError)
        end
      end

      context 'when asked for an available book' do
        it 'return true' do
          expect(inventory.reserve(available_book)).to eq(true)
        end

        it 'decrements its quantity by 1' do
          expect { inventory.reserve(available_book) }
            .to change { inventory.quantity(available_book) }.by(-1)
        end
      end

      context 'when asked for a last-one-left book' do
        it 'return true' do
          expect(inventory.reserve(one_left_book)).to eq(true)
        end

        it 'decrements its quantity from 1 to 0' do
          expect { inventory.reserve(one_left_book) }
            .to change { inventory.quantity(one_left_book) }.from(1).to(0)
        end
      end

      context 'when asked about an unavailable book' do
        it 'returns false' do
          expect(inventory.reserve(unavailable_book)).to eq(false)
        end

        it 'doesn\'t decrement its quantity below 0' do
          expect { inventory.reserve(unavailable_book) }
            .not_to change { inventory.quantity(unavailable_book) }
        end
      end
    end

    describe '#release' do
      context 'when asked for a shirt' do
        it 'raises error' do
          expect { inventory.release(shirt) }.to raise_error(ArgumentError)
        end
      end

      context 'when asked for an available book' do
        it 'return true' do
          expect(inventory.release(available_book)).to eq(true)
        end

        it 'increments its quantity by 1' do
          expect { inventory.release(available_book) }
            .to change { inventory.quantity(available_book) }.by(1)
        end
      end

      context 'when asked for a last-one-left book' do
        it 'return true' do
          expect(inventory.release(one_left_book)).to eq(true)
        end

        it 'increments its quantity from 1 to 2' do
          expect { inventory.release(one_left_book) }
            .to change { inventory.quantity(one_left_book) }.from(1).to(2)
        end
      end

      context 'when asked about an unavailable book' do
        it 'returns true' do
          expect(inventory.release(unavailable_book)).to eq(true)
        end

        it 'increments its quantity from 0 to 1' do
          expect { inventory.release(unavailable_book) }
            .to change { inventory.quantity(unavailable_book) }.from(0).to(1)
        end
      end
    end
  end
end
