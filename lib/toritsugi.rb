require "toritsugi/engine"
require "toritsugi/config"

module Toritsugi
  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield config if block_given?
  end
end
