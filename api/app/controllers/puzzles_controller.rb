class PuzzlesController < ApplicationController
  def show
    puzzle = Puzzle.find_by_slug(params[:slug])
    head :not_found and return if puzzle.blank?

    data = PuzzleSerializer.new(puzzle, serializer_options)

    json_response(data)
  end

  # Use it in maybe future when we have good servers
  def evaluate
    puzzle = Puzzle.find_by_slug(params[:slug])
    head :not_found and return if puzzle.blank?

    evaluation = puzzle.check_solution(solution_params)

    json_response({ evaluation: evaluation })
  end

  def random_puzzle 
    res = ::Puzzles::RandomPickerService.execute(strength: puzzle_strength)
    head :not_found and return unless res.success

    puzzle_data = PuzzleSerializer.new(res.data, serializer_options)

    json_response(puzzle_data)
  end

  private

  def puzzle_strength
    if params[:strength].present?
      params[:strength].to_i
    else
      user_puzzle_rating
    end
  end

  def solution_params
    params.require(:puzzle).permit(:index, :move)
  end

  def user_puzzle_rating
    return nil if current_user.blank?

    user_rating = current_user.ratings.find_or_create_by(rating_type: :puzzle)
    user_rating.rating
  end

  def serializer_options
    { include: [:rating] }
  end
end
