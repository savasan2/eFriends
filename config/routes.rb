Rails.application.routes.draw do
  get 'users/register' => 'users#register', as: 'user_register'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'homes#top'
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  namespace :admin do
    resources :genres, only: [:index, :create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
