module Shop
  class IndexBy
    def call(array)
      return {} unless array
      raise ArgumentError unless block_given?

      array.each_with_object({}) do |element, hash|
        hash[yield(element)] = element
        hash
      end
    end
  end
end
