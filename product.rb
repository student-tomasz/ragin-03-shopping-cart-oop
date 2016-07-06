class Product
  attr_reader :id, :name, :price, :vat_category_id

  def initialize(id:, name:, price:, vat_category_id:)
    @id = id
    @name = name
    @price = price
    @vat_category_id = vat_category_id
  end

  def eql? another
    another.instance_of?(self.class) && another.id == @id
  end

  alias_method :==, :eql?
end
