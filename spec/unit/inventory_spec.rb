require 'lib/catalog'
require 'lib/inventory'

RSpec.describe Inventory do
  let(:available_book) do
    Product.new(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_category_id: 2
    )
  end

  let(:unavailable_book) do
    Product.new(
      id: 3,
      name: 'Web Development with Clojure, Second Edition',
      price: 2400,
      vat_category_id: 2
    )
  end

  let(:one_left_book) do
    Product.new(
      id: 4,
      name: 'Serverless Single Page Apps',
      price: 3000,
      vat_category_id: 2
    )
  end

  let(:tshirt) do
    Product.new(
      id: 6,
      name: 'Pragmatic T-Shirt',
      price: 900,
      vat_category_id: 1
    )
  end

  let(:quantities) do
    {
      available_book.id => 19,
      unavailable_book.id => 0,
      one_left_book.id => 1,
      tshirt => 2
    }
  end

  it 'requires a list of products' do
    expect { Inventory.new(nil) }.to raise_error(ArgumentError)
  end

  context 'when stocked with books only' do
    let(:catalog) do
      Catalog.new([available_book, unavailable_book, one_left_book])
    end

    subject(:inventory) do
      Inventory.new(catalog, quantities)
    end

    describe '#quantity' do
      context 'when asked about a shirt' do
        it 'raises error' do
          expect { inventory.quantity(tshirt) }.to raise_error(ArgumentError)
        end
      end

      context 'when asked about an available book' do
        it 'returns > 0' do
          expect(inventory.quantity(available_book)).to be > 0
        end
      end

      context 'when asked about last one left book' do
        it 'returns > 0' do
          expect(inventory.quantity(one_left_book)).to eq(1)
        end
      end

      context 'when asked about an unavailable book' do
        it 'returns 0' do
          expect(inventory.quantity(unavailable_book)).to eq(0)
        end
      end
    end

    describe '#available?' do
      context 'when asked about a shirt' do
        it 'raises error' do
          expect { inventory.available?(tshirt) }.to raise_error(ArgumentError)
        end
      end

      context 'when asked about an available book' do
        it 'returns true' do
          expect(inventory.available?(available_book)).to be true
        end
      end

      context 'when asked about an unavailable book' do
        it 'returns false' do
          expect(inventory.available?(unavailable_book)).to be false
        end
      end
    end

    describe '#reserve' do
      context 'when asked for a shirt' do
        it 'raises error' do
          expect { inventory.reserve(tshirt) }.to raise_error(ArgumentError)
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
          expect { inventory.release(tshirt) }.to raise_error(ArgumentError)
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
