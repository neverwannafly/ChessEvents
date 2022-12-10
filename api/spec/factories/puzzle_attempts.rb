FactoryBot.define do
  factory :puzzle_attempt do
    rated { false }
    status { :pending }
  end
end
