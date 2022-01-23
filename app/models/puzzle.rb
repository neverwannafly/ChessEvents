class Puzzle < ApplicationRecord
  before_save :assign_slug

  def assign_slug
    slug = loop do
      slug = SecureRandom.alphanumeric(8)
      break slug unless self.class.exists?(slug: slug)
    end

    self.slug = slug
  end

  def self.get_random(strength = 1200)
    rating_deviation = 50
    low_rating = strength - rating_deviation
    high_rating = strength + rating_deviation

    self
      .where(rating: low_rating..high_rating)
      .order(Arel.sql('RAND()'))
      .limit(1)
      .first
  end
end
