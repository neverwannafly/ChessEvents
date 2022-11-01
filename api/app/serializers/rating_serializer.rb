class RatingSerializer
  include JSONAPI::Serializer

  attribute :rating_type, :rating, :rating_deviation, :volatility
end
