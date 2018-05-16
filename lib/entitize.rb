require 'pry'

require 'active_support/inflector'

require "entitize/version"
require "entitize/entities"
require "entitize/repo"
require "entitize/classifier"
require "entitize/entity"

module Entitize

  # TODO: Make this customizable
  def self.base_class
    Entities
  end

end
