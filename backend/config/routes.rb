# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :points do
    resources :comments, module: :points
  end
  resources :routes do
    resources :comments, module: :routes
  end
  resources :events do
    resources :events_users
  end

  resource :search, only: %i[show new edit]

  get 'welcome/index'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
