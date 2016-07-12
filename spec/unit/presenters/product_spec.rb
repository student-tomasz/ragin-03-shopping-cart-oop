RSpec.describe Shop::Presenters::Product do
  context 'for nil product' do
    describe '#new' do
      it 'raises error' do
        expect { Shop::Presenters::Product.new(nil) }
          .to raise_error(ArgumentError)
      end
    end
  end

  context 'for valid product' do
    let(:product) do
      Shop::Models::Product.new(
        id: 1,
        name: 'Agile Web Development with Rails 5',
        price: 2800,
        vat_id: 2
      )
    end

    subject(:product_presenter) { Shop::Presenters::Product.new(product) }

    describe '#id' do
      it 'returns product\'s id' do
        expect(product_presenter.id).to eq(product.id)
      end
    end

    describe '#name' do
      it 'returns product\'s name' do
        expect(product_presenter.name).to eq(product.name)
      end
    end

    describe '#price' do
      it 'returns formatted product\'s price' do
        expect(product_presenter.price).to eq('$28.00')
      end
    end

    describe '#price_with_vat' do
      it 'returns formatted product\'s price with vat' do
        expect(product_presenter.price_with_vat).to eq('$30.24')
      end
    end

    describe '#vat' do
      it 'returns formatted product\'s vat' do
        expect(product_presenter.vat).to eq('8%')
      end
    end
  end
end
