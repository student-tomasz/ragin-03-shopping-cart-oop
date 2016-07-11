module Shop
  class VAT
    class UnknownCategoryError < StandardError; end

    class << self
      private

      def new(*args)
        super(*args)
      end

      public

      def for_category(id)
        raise UnknownCategoryError unless @instances.key?(id)
        @instances[id]
      end
    end

    attr_reader :value

    def initialize(value)
      @value = value
    end

    @instances = {
      1 => new(0.23),
      2 => new(0.08)
    }.freeze
  end
end
