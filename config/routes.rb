Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'welcome#index'
  end
  resources :bars, except: [:destroy] do
    resources :comments
  end
end
