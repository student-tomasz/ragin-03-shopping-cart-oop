require 'lib/product'
require_relative 'services/index_by'

class Catalog
  def initialize(products = [])
    raise ArgumentError unless products
    @products = IndexBy.new.call(products, &:id)
  end

  def find(id)
    @products[id]
  end

  def all
    @products.values
  end
end
