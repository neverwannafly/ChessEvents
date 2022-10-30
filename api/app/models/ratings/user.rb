module Ratings
  class User < ::Rating
    enum rating_type: %i[hyperbullet bullet blitz rapid classical puzzle]
  end
end
