require 'rails_helper'

RSpec.describe ::Ratings::EvaluationService do
  let!(:puzzle) { create(:puzzle) }
  let!(:user) { create(:user) }
  let!(:puzzle_rating) { create(:puzzle_rating, rating: 1800, rating_type: :puzzle, owner: puzzle) }
  let!(:user_rating) { create(:user_rating, rating: 1400, rating_type: :puzzle, owner: user) }

  describe "#execute" do
    subject do
      ::Ratings::EvaluationService
    end

    context "when rating objects are compatible" do
      context "when first rating wins" do
        it 'should return success as true' do
          res = subject.execute(user_rating, puzzle_rating, result: ::Ratings::RESULTS[:rating1_win])
          expect(res.success).to be(true)
        end

        it 'should return valid result' do
          res = subject.execute(user_rating, puzzle_rating, result: ::Ratings::RESULTS[:rating1_win])
          ratings = res.data.map do |rating|
            rating.as_json.slice('rating_deviation', 'volatility', 'rating', 'owner_type')
          end
          expect(ratings).to match_array([{
            "rating_deviation"=>311.4129540744157,
            "volatility"=>0.06000186979181922,
            "rating"=>1707.6028572169848,
            "owner_type"=>"User"
          }, {
            "rating_deviation"=>311.4129540744156,
            "volatility"=>0.06000186979181922,
            "rating"=>1492.3971427830152,
            "owner_type"=>"Puzzle"
          }])
        end
      end

      context "when second rating wins" do
        it 'should return success as true' do
          res = subject.execute(user_rating, puzzle_rating, result: ::Ratings::RESULTS[:rating2_win])
          expect(res.success).to be(true)
        end

        it 'should return valid result' do
          res = subject.execute(user_rating, puzzle_rating, result: ::Ratings::RESULTS[:rating2_win])
          ratings = res.data.map do |rating|
            rating.as_json.slice('rating_deviation', 'volatility', 'rating', 'owner_type')
          end
          expect(ratings).to match_array([{
            "rating_deviation"=>311.41294517445056,
            "volatility"=>0.05999942311900612,
            "rating"=>1334.0946067690884,
            "owner_type"=>"User"
          }, {
            "rating_deviation"=>311.41294517445056,
            "volatility"=>0.05999942311900612,
            "rating"=>1865.9053932309116,
            "owner_type"=>"Puzzle"
          }])
        end
      end

      context "when result is a draw" do
        it 'should return correct data' do
          res = subject.execute(user_rating, puzzle_rating, result: ::Ratings::RESULTS[:draw])
          ratings = res.data.map do |rating|
            rating.as_json.slice('rating_deviation', 'volatility', 'rating', 'owner_type')
          end
          expect(ratings).to match_array([{
            "rating_deviation"=>311.41294618592326,
            "volatility"=>0.059999701186092366,
            "rating"=>1520.8487239869976,
            "owner_type"=>"User"
          }, {
            "rating_deviation"=>311.41294618592326,
            "volatility"=>0.059999701186092366,
            "rating"=>1679.1512760130026,
            "owner_type"=>"Puzzle"
          }])
        end
      end
    end

    context "when target is puzzle attempt and is rated" do
      let!(:puzzle_attempt) { create(:puzzle_attempt, puzzle: puzzle, solver: user, rated: true) }

      context "when service is executed" do
        it 'should return success as true' do
          res = subject.execute(user_rating, puzzle_rating, target: puzzle_attempt)
          expect(res.success).to eq(true)
        end

        it 'should create rating_change for user_rating' do
          subject.execute(user_rating, puzzle_rating, target: puzzle_attempt)
          expect(RatingChange.where(target: puzzle_attempt, rating: user_rating).present?).to be(true)
        end

        it 'should create rating_change for puzzle_rating' do
          subject.execute(user_rating, puzzle_rating, target: puzzle_attempt)
          expect(RatingChange.where(target: puzzle_attempt, rating: puzzle_rating).present?).to be(true)
        end
      end
    end

    # Todo: Complete this later
    context "when target is games and is rated" do
      
    end
  end
end
