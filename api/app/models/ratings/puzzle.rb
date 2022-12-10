module Ratings
  class Puzzle < ::Rating
    enum rating_type: %i[puzzle]

    def self.max_rating
      Rails.cache.fetch(::Puzzles::MIN_RATING_KEY, expires_in: 1.days) do
        self.order(rating: :desc).first.rating
      end
    end
  
    def self.min_rating
      Rails.cache.fetch(::Puzzles::MAX_RATING_KEY, expires_in: 1.days) do
        self.order(rating: :asc).first.rating
      end
    end
  end
end
