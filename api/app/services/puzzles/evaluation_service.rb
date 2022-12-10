module Puzzles
  class EvaluationService < ::ServiceBase
    def initialize(puzzle:, move_index:, move:, user:)
      @puzzle = puzzle
      @move_index = move_index
      @move = move
      @user = user

      @rated = is_rated?
    end

    def execute
      super do
        # Handle rating changes and other evaluation logic here
        success()
      end
    end

    private
  end
end
