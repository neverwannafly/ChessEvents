class Rating < ApplicationRecord
  self.inheritance_column = :owner_type

  belongs_to :owner, polymorphic: true

  def update_rating(target:, rating:)
    raise TypeError unless %w[PuzzleAttempt Game].include? target.class.name
    raise TypeError unless rating.is_a? Ratings::RatingStruct

    rating_difference = Ratings.difference(rating, self)
    rating_change_params = rating_difference.merge({
      rating_id: self.id,
      target: target
    })

    RatingChange.create(rating_change_params)
    self.update(rating.to_h.slice(:rating, :volatility, :rating_deviation))
  end
end
