Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  root to: 'posts#index'
  resources :messages, only: :create
  resources :rooms, only: [:create, :show, :index]
  resources :posts, except: :index do
    collection do
      get 'search'
      get 'drums'
      get 'bass'
      get 'keyboard'
      get 'guiter'
      get 'vocal'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
