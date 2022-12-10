module RatingConcern
  extend ActiveSupport::Concern

  included do
    # Takes opposition's rating object. Could be Ratings::Puzzle, Ratings::User etc.

    def calculate_win_loss_rating(opposition_rating_obj)
      self_rating_obj = get_compatible_rating(opposition_rating_obj.rating_type)

      rating_changes = {}

      ::Ratings::RESULTS.each do |key, value|
        new_self_rating_obj = ::Ratings::EvaluationService.execute(
          self_rating_obj,
          opposition_rating_obj,
          result: value
        ).data.first

        rating_changes[key] = ::Ratings::difference(new_self_rating_obj, self_rating_obj)
      end
      
      rating_changes
    end

    def get_compatible_rating(rating_type)
      return self.rating if self.respond_to? :rating

      self.ratings.where(rating_type: rating_type).first
    end
  end
end
