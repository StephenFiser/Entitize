module Entitize
  class Entity
    class << self

      # Can data be an array?
      def generate(data, class_name)
        get_class(class_name, data).new(data)
      end

      def get_class(class_name, data)
        if Object.const_defined?(class_name)
          Object.const_get(class_name)
        else
          Object.const_set(class_name, ClassBuilder.build(data))
        end
      end

    end
  end
end
