class VAT
  @values = {
    0 => 0.00,
    1 => 0.23,
    2 => 0.08
  }.freeze

  def self.for_category(id)
    VAT.new(@values[id] || @values[0])
  end

  attr_reader :value

  def eql?(other)
    other.instance_of?(self.class) && other.value == @value
  end

  alias == eql?

  private

  def initialize(value)
    @value = value
  end
end
