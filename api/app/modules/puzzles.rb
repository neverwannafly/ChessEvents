module Puzzles
  COUNT_KEY = "PUZZLES::COUNT_KEY"
  PUZZLE_NOT_FOUND = "Puzzles for your specification were not found!"
  MIN_RATING_KEY = "PUZZLES::MIN_RATING_KEY"
  MAX_RATING_KEY = "PUZZLES::MAX_RATING_KEY"

  MOVE_STATE_MAPPING = {
    invalid: 0,
    incorrect: 1,
    correct: 2,
    solved: 3
  }

  def max_rating
    Rails.cache.fetch(MIN_RATING_KEY, expires_in: 1.days) do
      Ratings::Puzzle.order(rating: :desc).first.rating
    end
  end

  def min_rating
    Rails.cache.fetch(MAX_RATING_KEY, expires_in: 1.days) do
      Ratings::Puzzle.order(rating: :asc).first.rating
    end
  end

  module_function :max_rating, :min_rating
end
