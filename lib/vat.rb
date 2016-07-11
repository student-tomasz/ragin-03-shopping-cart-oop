module Shop
  class VAT
    class << self
      private

      def new(*args)
        super(*args)
      end

      public

      def for_category(id)
        @instances[id] || @instances[0]
      end
    end

    def initialize(value)
      @value = value
    end

    @instances = {
      0 => new(0.00),
      1 => new(0.23),
      2 => new(0.08)
    }.freeze

    attr_reader :value
  end
end
