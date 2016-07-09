RSpec.describe IndexBy do
  let(:book) do
    Product.new(
      id: 1,
      name: 'Agile Web Development with Rails 5',
      price: 2800,
      vat_category_id: 2
    )
  end

  let(:another_book) do
    Product.new(
      id: 3,
      name: 'Web Development with Clojure, Second Edition',
      price: 2400,
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

  describe '#call' do
    shared_examples 'hash that' do |count|
      it "has #{count} keys" do
        expect(indexed_by.keys.length).to eq(count)
      end

      it "has #{count} values" do
        expect(indexed_by.values.length).to eq(count)
      end

      it "has all #{count} unique products as values" do
        expect(indexed_by.values).to include(*products)
      end
    end

    context 'with an array of 3 unique products' do
      let(:products) { [book, another_book, tshirt] }

      context "and a block calling item's #id" do
        subject(:indexed_by) { IndexBy.new.call(products, &:id) }

        it_behaves_like 'hash that', 3

        it 'has keys that are ids of the products' do
          expect(indexed_by.keys).to include(*products.map(&:id))
        end
      end

      context "and a block calling products's #name" do
        subject(:indexed_by) { IndexBy.new.call(products, &:name) }

        it_behaves_like 'hash that', 3

        it 'has keys that are names of the products' do
          expect(indexed_by.keys).to include(*products.map(&:name))
        end
      end
    end

    context 'with an array of one book, and a doubled tshirt' do
      let(:products) { [book, tshirt, tshirt] }
      subject(:indexed_by) { IndexBy.new.call(products, &:id) }

      it_behaves_like 'hash that', 2
    end

    context 'with an empty array' do
      subject(:indexed_by) { IndexBy.new.call([], &:id) }

      it { is_expected.to eq({}) }
    end

    context 'with nil' do
      subject(:indexed_by) { IndexBy.new.call(nil, &:id) }

      it { is_expected.to eq({}) }
    end

    context 'without a block' do
      it 'raises error' do
        expect { IndexBy.new.call([book, another_book]) }
          .to raise_error ArgumentError
      end
    end
  end
end
