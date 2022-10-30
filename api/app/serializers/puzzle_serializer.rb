class PuzzleSerializer
  include JSONAPI::Serializer

  attributes :starting_position_fen, :slug, :initial_popularity, :upvotes, :downvotes

  attribute :solution do |obj|
    Base64.encode(obj.solution)
  end
end