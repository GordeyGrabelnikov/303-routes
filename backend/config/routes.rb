# frozen_string_literal: true

Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users

  authenticate :user, -> (user) { user.admin? } do
    mount PgHero::Engine, at: "pgdashboard"
  end


  resources :comments do
    resources :comments
  end

  resources :points do
    patch :update_point_status, on: :member
    resources :comments
  end
  resources :routes do
    patch :update_route_status, on: :member

    resources :comments
  end

  resources :events do
    post :follow, on: :member
    post :unfollow, on: :member
    patch :update_event_status, on: :member

    resources :events_users
  end

  resources :users, only: %i[show]


  get 'welcome/index'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
