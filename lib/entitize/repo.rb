module Entitize
  class Repo

    attr_reader :token

    def initialize(settings = {})
      @token = settings[:token]
    end

    def method_missing(query, *args, &block)
      data_source_class = args[0]
      options           = args[1] || {}
      arguments         = options[:args] || []
      class_name_to_use = options[:entity] || data_source_class.to_s

      # TODO: add in all settings as first args -> e.g. pub_key, secret_key
      arguments.unshift(token) unless token.nil?
      data = data_source_class.send(query, *arguments)

      Entitize::Entity.generate(data, class_name_to_use)
    end

  end
end
