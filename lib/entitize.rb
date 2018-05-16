require 'active_support/inflector'

require "entitize/entities"
require "entitize/version"
require "entitize/classifier"
require "entitize/entity"

module Entitize

  # TODO: Make this customizable
  def self.base_class
    Entities
  end

end
