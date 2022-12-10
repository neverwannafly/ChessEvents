FactoryBot.define do
  factory :puzzle do
    starting_position_fen { 'r6k/pp2r2p/4Rp1Q/3p4/8/1N1P2R1/PqP2bPP/7K b - - 0 24' }
    solution { 'f2g3 e6e7 b2b1 b3c1 b1c1 h6c1' }
    slug { '00008uXPc' }
    initial_popularity { 95 }
    upvotes { 100 }
    downvotes { 10 }
  end
end
