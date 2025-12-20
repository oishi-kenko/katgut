module Katgut
  class Config
    include ActiveSupport::Callbacks
    extend ActiveSupport::Concern

    class_attribute :after_redirection_callback, default: nil
    class_attribute :fall_back_path, default: '/'
  end
end
