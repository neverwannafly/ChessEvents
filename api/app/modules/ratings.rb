module Ratings
  INVALID_RATING_OBJECT_COMPARISON_ERROR = "The rating objects being compared are invalid"
  include ::Exceptions

  RatingStruct = Struct.new(
    :id,
    :owner_type,
    :rating,
    :rating_deviation,
    :volatility,
    :rating_type,
    keyword_init: true
  )

  DEFAULT_RATING = 1500

  RESULTS = {
    rating1_win: [1, 2],
    rating2_win: [2, 1],
    draw: [2, 2]
  }

  # Find difference between any instances of RatingStruct or subclass of Rating
  # Order: rating_obj1 - rating_obj2

  def self.difference(rating_obj1, rating_obj2)
    rating1, rating2 = rating_obj1.rating, rating_obj2.rating
    volatility1, volatility2 = rating_obj1.volatility, rating_obj2.volatility
    deviation1, deviation2 = rating_obj1.rating_deviation, rating_obj2.rating_deviation

    {
      rating_change: rating1 - rating2,
      volatility_change: volatility1 - volatility2,
      deviation_change: deviation1 - deviation2
    }
  end

  # Checks if two rating objects are compatible with each other or not
  # Compatibile rating types can only be compared against each other for
  # Evaluation. Eg: Bullet ratings and Standard ratings of a user
  # cant be equated with each other. Shift this to a policy in future

  def self.validate_rating_compatibility!(rating1, rating2)
    rating_class1 = rating1.owner_type
    rating_class2 = rating2.owner_type

    if rating_class1 == rating_class2
      # For 2 user ratings, their rating type must be same
      if rating_class1 == User.class.name && rating1.rating_type == rating2.rating_type
        return true
      end
    else
      # This means one of the ratings is a puzzle and one is user.
      # then rating_types of both objects must be 'puzzle'
      if rating1.rating_type == rating2.rating_type && rating1.rating_type == 'puzzle'
        return true
      end
    end

    raise ::Ratings::InvalidRatingObjectComparisonError
  end
end
