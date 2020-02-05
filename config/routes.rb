Rails.application.routes.draw do
  root 'sessions#new'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :feeds do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    collection do
      get :favorite_index
    end
  end
  resources :favorites, only: [:create, :destroy]
end
