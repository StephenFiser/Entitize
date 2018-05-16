module Entitize
  class Entity
    class << self

      # TODO: Can data be an array?
      def generate(data, class_name)
        Classifier.get_class(class_name, data).new(data)
      end

    end

    def initialize(data)
      Classifier.define_methods(data, self)
    end
  end
end
