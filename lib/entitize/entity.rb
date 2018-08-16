module Entitize
  class Entity
    class << self

      def generate(data, class_name)
        Entitize::Classifier.generate(data, class_name)
      end

      def auto_new(*args, &block)
        instance = allocate
        instance.auto_initialize(*args, &block)
        instance
      end

    end # --> END CLASS METHODS

    def initialize(data)
      Entitize::Classifier.define_methods(data, self)
    end

    def auto_initialize(data)
      Entitize::Classifier.define_methods(data, self)
    end
  end
end
