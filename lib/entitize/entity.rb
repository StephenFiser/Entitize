module Entitize
  class Entity
    class << self

      def generate(data, class_name)
        Entitize::Classifier.generate(data, class_name)
      end

    end # --> END CLASS METHODS

    def initialize(data)
      Entitize::Classifier.define_methods(data, self)
    end
  end
end
