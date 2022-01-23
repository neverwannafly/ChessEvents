module Api
  class PuzzlesController < ApplicationController
    def random_puzzle
      user_rating = current_user.ratings.find_or_create_by(rating_type: :puzzle)
      puzzle = Puzzle.get_random(strength: user_rating.rating)

      head :not_found and return if puzzle.blank?

      json_response({
        puzzle: puzzle.as_json,
        themes: puzzle.themes.as_json
      })
    end
  end
end
