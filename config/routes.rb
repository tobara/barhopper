Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'welcome#index'
    get 'login', to: 'devise/sessions#new'
  end
  resources :bars, except: [:destroy] do
    resources :comments
    resources :days
  end
  resources :bars do
    member do
      put "like", to: "bars#upvote"
      put "dislike", to: "bars#downvote"
    end
  end
end
