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

  def self.is_rated?(user, puzzle)
    return false unless user.present?

    last_puzzle_attempt = user.puzzle_attempts.last
    return true if last_puzzle_attempt.nil?


  end
end
