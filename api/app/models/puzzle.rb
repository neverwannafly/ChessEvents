class Puzzle < ApplicationRecord
  include ::RatingConcern

  before_save :assign_slug

  has_many :theme_associations, as: :associate
  has_many :themes, through: :theme_associations
  has_one :rating, class_name: '::Ratings::Puzzle', foreign_key: :owner_id

  def assign_slug
    slug = loop do
      slug = SecureRandom.alphanumeric(10)
      break slug unless self.class.exists?(slug: slug)
    end

    self.slug = slug
  end
end
