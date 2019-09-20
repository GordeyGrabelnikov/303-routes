# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :comments do
    resources :comments
  end

  resources :points do
    patch :update_point_status, on: :member
    resources :comments
  end
  resources :routes do
    resources :comments
  end

  resources :events do
    resources :events_users
  end

  resource :search, only: %i[show new edit]

  get 'welcome/index'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
