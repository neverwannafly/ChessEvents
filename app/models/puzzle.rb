class Puzzle < ApplicationRecord
  before_save :assign_slug

  has_many :theme_associations, as: :associate

  MIN_RATING = 500

  def themes
    self.theme_associations.joins(:theme).select('themes.*')
  end

  def json_data
    {
      puzzle: self.as_json,
      themes: self.themes.as_json
    }
  end

  def assign_slug
    slug = loop do
      slug = SecureRandom.alphanumeric(8)
      break slug unless self.class.exists?(slug: slug)
    end

    self.slug = slug
  end

  def self.random(strength: 1200, id_ceiling: nil)
    rating_deviation = 50
    low_rating = [strength - rating_deviation, MIN_RATING].max
    high_rating = [strength + rating_deviation, MIN_RATING + 3 * rating_deviation].max
    id_lower_ceiling = id_ceiling || self.random_puzzle_id_seed
    puzzle = self.where(rating: low_rating..high_rating, id: id_lower_ceiling..).first

    if puzzle.blank? and id_lower_ceiling > 0
      puzzle = self.get_random(strength: strength, id_ceiling: id_lower_ceiling/2)
    end

    puzzle
  end

  def self.random_puzzle_id_seed
    upper_ceiling = 80000
    upper_ceiling = 2000000 unless Rails.env.development?

    rand(0..upper_ceiling)
  end
end
