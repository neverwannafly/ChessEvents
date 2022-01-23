module Api
  class PuzzlesController < ApplicationController
    def random_puzzle 
      puzzle = Puzzle.random(strength: params[:strength] || user_puzzle_rating)
      head :not_found and return if puzzle.blank?

      json_response({
        puzzle: puzzle.as_json,
        themes: puzzle.themes.as_json
      })
    end

    private

    def user_puzzle_rating
      return nil if current_user.blank?

      user_rating = current_user.ratings.find_or_create_by(rating_type: :puzzle)
      user_rating.rating
    end
  end
end
