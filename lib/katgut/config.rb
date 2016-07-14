module Katgut
  class Config
    include ActiveSupport::Configurable
    config_accessor :after_redirection_callback, :fall_back_path

    configure do |config|
      config.after_redirection_callback = nil
      config.fall_back_path = '/'
    end
  end
end
