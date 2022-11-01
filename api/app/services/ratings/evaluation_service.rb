# Service for calculating loss/gain of ratings when given two rating objects
# When update is set to false, rating data wont be updated in the DB

module Ratings
  class EvaluationService < ::ServiceBase

    def initialize(rating1, rating2, target: nil, result: ::Ratings::RESULTS[:rating1_win])
      @rating1 = to_struct(rating1)
      @rating2 = to_struct(rating2)
      @result = result
      @target = target
    end

    def execute
      super do
        ratings = [@rating1, @rating2]

        ::Ratings.validate_rating_compatibility!(*ratings)
        calculate_new_ratings(ratings)
        update_ratings(ratings) if @target.present?

        success(ratings)
      end
    end

    private

    # Mutates rating inplace
    def calculate_new_ratings(ratings)
      period = Glicko2::RatingPeriod.from_objs(ratings)
      period.game(ratings, @result)
      period.generate_next(0.5).players.each(&:update_obj)
    end

    def update_ratings(ratings)
      ratings.each do |rating|
        "Ratings::#{rating.owner_type}"
          .constantize
          .find(rating.id)
          .update_rating(target: @target, rating: rating)
      end
    end

    def to_struct(rating_obj)
      ::Ratings::RatingStruct.new(rating_obj.slice(::Ratings::RatingStruct.members))
    end
  end
end
