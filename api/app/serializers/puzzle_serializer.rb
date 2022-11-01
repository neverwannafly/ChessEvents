class PuzzleSerializer
  include JSONAPI::Serializer

  attributes :starting_position_fen, :slug, :initial_popularity, :upvotes, :downvotes

  attribute :solution do |obj|
    Base64.encode64(obj.solution)
  end

  attribute :rating_changes,
    if: Proc.new { |obj, params| params[:user].present? } do |obj, params|
      params[:user].calculate_win_loss_rating(obj.rating)
    end

  has_one :rating
end
