FactoryBot.define do
  factory :rating do
    rating { 1200 }
    volatility { 0.06 }
    rating_deviation { 350 }
  end

  factory :user_rating, class: Ratings::User, parent: :rating do
    association :owner, factory: :user
    rating_type { :puzzle }
  end

  factory :puzzle_rating, class: Ratings::Puzzle, parent: :rating do
    association :owner, factory: :puzzle
    rating_type { :puzzle }
  end
end
