# Returns a random puzzle around a rating range.

module Puzzles
  class RandomPickerService < ::ServiceBase

    def initialize(strength:, rating_deviation: 50)
      @strength = strength
      @rating_deviation = rating_deviation
    end

    attr_accessor :rating_deviation, :strength

    def execute
      super do
        low_rating = [strength - rating_deviation, MIN_RATING].max
        high_rating = [strength + rating_deviation, MIN_RATING + 2 * rating_deviation].max

        puzzle = fetch_random_puzzle(low_rating, high_rating)

        if puzzle.present?
          success(puzzle)
        else
          error(PUZZLE_NOT_FOUND)
        end
      end
    end

    private

    def fetch_random_puzzle(low_rating, high_rating, lower_ceiling = nil)
      lower_ceiling_id = lower_ceiling || random_puzzle_id
      puzzle = fetch_puzzle(low_rating, high_rating, lower_ceiling)

      debugger
      if puzzle.blank? and lower_ceiling_id > 0
        puzzle = fetch_random_puzzle(low_rating, high_rating, lower_ceiling_id/2)
      end

      puzzle
    end

    def fetch_puzzle(low_rating, high_rating, lower_ceiling)
      Puzzle
        .joins(:rating)
        .where({
          ratings: { rating: low_rating..high_rating },
          puzzles: { id: lower_ceiling.. }
        })
        .first
    end

    def random_puzzle_id
      puzzles_count = Rails.cache.fetch(PUZZLE_COUNT_KEY, expires_in: 1.hours) { Puzzle.count }
      rand(1..puzzles_count)
    end
  end
end
