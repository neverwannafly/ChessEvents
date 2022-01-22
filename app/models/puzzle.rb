class Puzzle < ApplicationRecord
  before_save :assign_slug

  def assign_slug
    slug = loop do
      slug = SecureRandom.alphanumeric(8)
      break slug unless self.class.exists?(slug: slug)
    end

    self.slug = slug
  end
end
