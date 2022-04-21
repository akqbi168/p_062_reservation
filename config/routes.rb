Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: [:edit, :update]
  get "users/mypage", :to => "users#show"

  resources :properties do
    post 'multiple_updates', on: :member
  end

  resources :entities, only: [:index]
  resources :carts, only: [:create]

  resources :reservations, only: [:index, :new, :create, :show] do
    collection do
      post :confirm
    end
  end

  resources :reputations do
    collection do
      patch :update_hidden
    end
  end

  resources :favorites, only: [:create, :destroy]

  get "welcome", :to => "homes#welcome"
  root "homes#top"

end
