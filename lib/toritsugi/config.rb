module Toritsugi
  class Config
    include ActiveSupport::Configurable
    config_accessor :after_redirection_callback

    configure do |config|
      config.after_redirection_callback = nil
    end
  end
end
