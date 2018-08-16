# require 'pry'

require 'active_support/inflector'

require "entitize/version"
require "entitize/repo"
require "entitize/classifier"
require "entitize/entitizable"
require "entitize/entity"

module Entities
end

module Entitize

  # TODO: Make this customizable
  def self.base_class
    Entities
  end

end
