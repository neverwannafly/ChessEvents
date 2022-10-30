module Puzzles
  class EvaluationService < ::ServiceBase
    def initialize(puzzle:, move:, rated:)
      @puzzle = puzzle
      @move = move
      @rated = rated
    end

    def execute
      super do
        # Handle rating changes and other evaluation logic here
        success()
      end
    end
  end
end
