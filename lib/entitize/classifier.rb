module Entitize
  class Classifier

    def self.get_class(class_name, data)
      if Object.const_defined?(class_name)
        Object.const_get(class_name)
      else
        Object.const_set(class_name, Entitize::Classifier.build(data))
      end
    end

    # TODO: why singleton?
    def self.define_methods(data, target)
      data.each do |key, value|
        target.define_singleton_method key do
          if value.is_a? Array
            Entitize::Classifier.create_set(key, value)
          elsif value.is_a? Hash
            Entitize::Classifier.create_one(key, value)
          else
            value
          end
        end
      end
    end

    # TODO: shouldn't rely on String#capitalize here!
    # TODO: what if *some* of the items in a collection are objects and some are not?
    # TODO: replace [0..-2] with version of Rails singularize
    def self.create_set(class_name, dataset)
      dataset.map do |object|
        Entitize::Classifier.create_one(class_name, object)
      end
    end

    def self.create_one(class_name, object)
      Entitize::Entity.generate(object, class_name.to_s.capitalize[0..-2])
    end

    def self.build(data)
      Class.new do
        def initialize(data)
          Entitize::Classifier.define_methods(data, self)
        end
      end
    end
  end
end
