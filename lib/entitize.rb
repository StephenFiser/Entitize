require 'active_support/inflector'

require "entitize/version"
require "entitize/repo"
require "entitize/classifier"
require "entitize/entitizable"
require "entitize/entity"

module Entities
end

module Entitize
  class Configuration
    attr_accessor :base_class

    def initialize
      @base_class = Entities
    end
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def set_base_class(base_class)
      configuration.base_class = base_class
    end

    def base_class
      configuration.base_class
    end
  end

end
