module Shop
  module Models
    class VAT
      UnknownCategoryError = Class.new(ArgumentError)

      class << self
        def for_category(id)
          raise UnknownCategoryError unless @instances.key?(id)
          @instances[id]
        end

        private

        def new(*args)
          super(*args)
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
end
