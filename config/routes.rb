Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"

  namespace :api do
    resources :registrations, only: %i[create]
    resources :sessions, only: %i[create destroy]

    namespace :puzzles do
      get 'random-puzzle', action: 'random_puzzle'
    end
  end

  get "*any" => "home#index"
end
