require_relative '../../lib/catalog'
require_relative '../../lib/product'

RSpec.shared_examples 'an empty catalog' do
  describe '#all' do
    it 'contains no products' do
      expect(catalog.all).to be_empty
    end
  end
end

RSpec.describe Shop::Catalog do
  let(:book) do
    Shop::Product.new(
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_id: 2
    )
  end

  let(:tshirt) do
    Shop::Product.new(
      name: 'Pragmatic T-Shirt',
      price: 900,
      vat_id: 1
    )
  end

  let(:not_in_offer_book) do
    Shop::Product.new(
      name: 'Web Development with Clojure, Second Edition',
      price: 2400,
      vat_id: 2
    )
  end

  context 'when created with a nil' do
    it 'raises an error' do
      expect { Shop::Catalog.new(nil) }.to raise_error(ArgumentError)
    end
  end

  context 'when created with an empty list of products' do
    subject(:catalog) { Shop::Catalog.new([]) }

    it_behaves_like 'an empty catalog'
  end

  context 'when created without any argument' do
    subject(:catalog) { Shop::Catalog.new }

    it_behaves_like 'an empty catalog'
  end

  context 'when created with a list of a book and a tshirt' do
    subject(:catalog) { Shop::Catalog.new([book, tshirt]) }

    describe '#all' do
      it 'contains 2 products' do
        expect(catalog.all.length).to eq(2)
      end

      it 'contains the book' do
        expect(catalog.all).to include(book)
      end

      it 'contains the tshirt' do
        expect(catalog.all).to include(tshirt)
      end

      it 'doesn\'t contain a book not in the offer' do
        expect(catalog.all).not_to include(not_in_offer_book)
      end
    end

    describe '#find' do
      context 'when given an id of a product in the offer' do
        subject(:found_product) { catalog.find(book.id) }

        it 'returns the product' do
          expect(found_product).to eq(book)
        end
      end

      context 'when given an id of a product not in the offer' do
        subject(:found_product) { catalog.find(not_in_offer_book.id) }

        it 'returns nil' do
          expect(found_product).to be(nil)
        end
      end
    end
  end
end
