Rails.application.routes.draw do
  get 'users/register' => 'users#register', as: 'user_register'
  get 'users/match' => 'users#match', as: 'user_match'
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
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
