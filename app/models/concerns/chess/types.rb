module Chess
  module Types
    extend ActiveSupport::Concern

    included do
      enum type: %i[hyperbullet bullet blitz rapid classical]
    end
  end
end
