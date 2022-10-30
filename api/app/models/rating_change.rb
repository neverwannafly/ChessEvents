class RatingChange < ApplicationRecord
  belongs_to :target, polymorphic: true
end