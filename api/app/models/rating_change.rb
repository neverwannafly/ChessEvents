class RatingChange < ApplicationRecord
  belongs_to :target, polymorphic: true
  belongs_to :rating
end
