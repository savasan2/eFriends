Rails.application.routes.draw do
  root to: 'homes#top'
  get 'chat/:id' => 'chats#show', as: 'chat'
  post 'chat/create/:id' => 'chats#create', as: 'chat_create'
  resources :notifications, only: [:index]

  get 'users/register' => 'users#register', as: 'user_register'
  get 'users/matched' => 'users#matched', as: 'user_matched'
  get 'users/show' => 'users#show', as: 'user'
  get 'users/search' => 'users#search', as: 'search'
  post 'users/result' => 'users#result', as: 'result'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :users, only: [:index, :edit, :update, :destroy]

  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :genres, only: [:index, :create, :destroy]
  end

  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'follow/search/:id' => 'relationships#follow_search', as: 'follow_search'
  get 'skip/:id' => 'relationships#skip', as: 'skip'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
