Rails.application.routes.draw do
  root 'sessions#new'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :feeds do
    collection do
      post :confirm
    end
  end
  resources :sessions
  resources :users
  resources :favorites, only: [:index, :create, :destroy]
end
