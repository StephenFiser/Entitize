module Entitize
  module Entitizable
    module ClassMethods

      def generate(data, class_name = nil)
        Entitize::Classifier.generate(data, class_name)
      end

      def auto_new(*args, &block)
        instance = allocate
        instance.auto_initialize(*args, &block)
        instance
      end

    end

    def self.included(klass)
      klass.extend(ClassMethods)
    end


    def auto_initialize(data)
      Entitize::Classifier.define_methods(data, self)
    end

  end
end
