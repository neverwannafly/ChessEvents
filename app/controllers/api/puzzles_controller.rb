module Api
  class PuzzlesController < ApplicationController
    def random_puzzle
      user_rating = current_user.ratings.find_or_create_by(rating_type: :puzzle)
      puzzle = Puzzle.get_random(user_rating.rating)

      json_response puzzle.as_json
    end

    def show

    end
  end
end
