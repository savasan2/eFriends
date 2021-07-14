Rails.application.routes.draw do
  get 'users/register' => 'users#register', as: 'user_register'
  get 'users/matched' => 'users#matched', as: 'user_matched'
  get 'chat/:id' => 'chats#show', as: 'chat'
  post 'chat/create/:id' => 'chats#create', as: 'chat_create'
  resources :notifications, only: [:index]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'homes#top'
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  namespace :admin do
    resources :genres, only: [:index, :create, :destroy]
  end

  post 'follow/:id' => 'relationships#follow', as: 'follow'
  get 'skip/:id' => 'relationships#skip', as: 'skip'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
