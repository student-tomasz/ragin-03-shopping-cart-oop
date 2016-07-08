require 'lib/product'

class Catalog
  def initialize(products = [])
    raise(ArgumentError) if products.nil?
    @products = Hash[products.map { |product| [product.id, product] }].freeze
  end

  def find(id)
    @products[id]
  end

  def all
    @products.values
  end
end
