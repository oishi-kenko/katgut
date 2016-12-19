require 'securerandom'

module Katgut
  class Rule < ActiveRecord::Base
    ALLOWED_SCHEMES            = [:https, :http]
    DEFAULT_SCHEME             = :http
    MINIMUM_SOURCE_LENGTH      = 5
    MAXIMUM_DESTINATION_LENGTH = 2083    # Limitation for IE / Edge

    scope :active, -> { where(active: true) }

    validates :source,
      uniqueness: true,
      presence:   true,
      format:     { with: /\A[a-zA-Z0-9\-_]*\z/ },
      length:     { in: MINIMUM_SOURCE_LENGTH .. 255 }
    validates :destination,
      presence: true,
      format:   { without: URI::UNSAFE },
      length:   { maximum: MAXIMUM_DESTINATION_LENGTH }
    validate :ensure_destination_has_no_unallowed_scheme

    after_initialize :set_random_source, if: -> { new_record? && source.nil? }

    def regular_destination
      if URI.extract(destination).present?
        destination
      else
        case destination
        when /\A\//
          destination
        else
          "#{self.class::DEFAULT_SCHEME}://#{destination}"
        end
      end
    end

    private

    class << self
      def allowed_schemes_with_suffix
        ALLOWED_SCHEMES.map {|s| "#{s}://" }
      end

      def unallowed_scheme_in?(url)
        if url.present?
          !URI.extract(url).all? do |str|
            ALLOWED_SCHEMES.include? URI.split(str)[0].to_sym
          end
        else
          false
        end
      end
    end

    def ensure_destination_has_no_unallowed_scheme
      if self.class.unallowed_scheme_in?(destination)
        errors.add(:destination, "has unallowed scheme.")
      end
    end

    def set_random_source
      self.source = SecureRandom.urlsafe_base64(6)
    end
  end
end
