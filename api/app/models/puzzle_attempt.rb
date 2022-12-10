class PuzzleAttempt < ApplicationRecord
  belongs_to :solver, polymorphic: true
  belongs_to :puzzle

  enum status: %i[pending incorrect correct]

  def rated?
    self.rated
  end
end
