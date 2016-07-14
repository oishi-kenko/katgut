require "katgut/engine"
require "katgut/config"

module Katgut
  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield config if block_given?
  end
end
