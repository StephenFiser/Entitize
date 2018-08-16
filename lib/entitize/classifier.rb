require 'pry'

module Entitize
  class Classifier
    class << self

      def generate(data, class_name)
        if data.is_a? Array
          get_classes(class_name, data)
        else
          get_class(class_name, data)
        end
      end

      # QUESTION: why singleton?
      def define_methods(data, target)
        classifier = self
        data.each do |key, value|
          target.define_singleton_method key do
            if value.is_a? Array
              classifier.create_set(key, value)
            elsif value.is_a? Hash
              classifier.create_one(key, value)
            else
              value
            end
          end
        end
      end

      def get_class(class_name, data)

        if base_class.const_defined?(class_name)

          klass = base_class.const_get(class_name)
          if klass.to_s.include?("#{Entitize.base_class.to_s}::")
            klass
          else
            base_class.const_set(class_name, build(data))
          end
        else
          base_class.const_set(class_name, build(data))
        end.auto_new(data)
      end

      def get_classes(class_name, data)
        data.map { |d| get_class(class_name, d) }
      end

      def create_set(class_name, dataset)
        dataset.map do |object|
          Entitize::Classifier.create_one(class_name, object)
        end
      end

      def create_one(class_name, object)
        generate(object, get_class_name(class_name))
      end

      def build(data)
        Class.new(Entitize::Entity) do
          def initialize(data)
            Entitize::Classifier.define_methods(data, self)
          end
        end
      end

      def get_class_name(base)
        base.to_s.camelize.singularize
      end

      def base_class
        Entitize.base_class
      end
    end # --> END CLASS METHODS

  end
end
