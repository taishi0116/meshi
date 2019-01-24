Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, param: :username, path: '/', only: [:show, :edit, :update, :destroy] do
    resources :messages, only: [:index]
    resources :invites, only: [:new, :show, :index, :create, :delete] do
      resources :messages, only: [:new, :index, :show, :create] do
        resources :created, only: [:index]
      end
    end
  end
end
