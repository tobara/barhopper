Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'welcome#index'
  end
  resources :bars, except: [:destroy] do
    resources :comments
  end
  resources :bars do
    member do
      put "like", to: "bars#upvote"
      put "dislike", to: "bars#downvote"
    end
  end
end
