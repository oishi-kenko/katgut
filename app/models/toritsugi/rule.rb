module Toritsugi
  class Rule < ActiveRecord::Base
    ALLOWED_SCHEMES = [:https, :http]
    DEFAULT_SCHEME = :http

    validates :source,
      uniqueness: true,
      presence: true,
      length: { maximum: 255 }
    validates :destination,
      presence: true,
      length: { maximum: 255 }

    def regular_destination
      if URI.extract(destination).present?
        destination
      else
        case destination
        when /\A(#{self.class.allowed_schemes_with_suffix.join('|')})/
          destination
        when /\A\//
          destination
        else
          "#{self.class::DEFAULT_SCHEME}://#{destination}"
        end
      end
    end

    private

    def self.allowed_schemes_with_suffix
      ALLOWED_SCHEMES.map {|s| "#{s}://" }
    end
  end
end
