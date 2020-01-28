Rails.application.routes.draw do
  root 'sessions#new'
  resources :feeds do
    collection do
      post :confirm
    end
  end
  resources :sessions
  resources :users
end
