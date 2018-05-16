class ClassBuilder

  def self.build(data)
    Class.new do

      def initialize(data)
        define_methods(data)
      end

      # TODO: why singleton?
      # TODO: add case for Hash
      def define_methods(data)
        data.each do |key, value|
          define_singleton_method key do
            if value.is_a? Array
              create_set(key, value)
            else
              value
            end
          end
        end
      end

      # TODO: shouldn't rely on String#capitalize here!
      # TODO: what if *some* of the items in a collection are objects and some are not?
      # TODO: replace [0..-2] with version of Rails singularize
      def create_set(class_name, dataset)
        dataset.map do |object|
          Entitize::Entity.generate(object, class_name.to_s.capitalize[0..-2])
        end
      end

    end
  end
end
