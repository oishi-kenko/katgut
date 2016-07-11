module Toritsugi
  class Rule < ActiveRecord::Base
    validates :source,
      uniqueness: true,
      presence: true,
      length: { maximum: 255 }
    validates :destination,
      presence: true,
      length: { maximum: 255 }
  end
end
