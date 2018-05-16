module Entitize
  class Entity
    class << self

      def generate(data, class_name)
        if data.is_a? Array
          data.map { |d| Classifier.get_class(class_name, d).new(d) }
        else
          Classifier.get_class(class_name, data).new(data)
        end
      end

    end

    def initialize(data)
      Classifier.define_methods(data, self)
    end
  end
end
