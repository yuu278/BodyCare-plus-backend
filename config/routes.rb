Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/register', to: 'auth#register'
      post 'auth/login', to: 'auth#login'
      post 'auth/guest_login', to: 'auth#guest_login'

      get 'me', to: 'users#me'

      resources :users, only: [:show, :update]
      resources :body_assessments
      resources :stretches, only: [:index, :show]

      get 'user_stretches/recommended', to: 'user_stretches#recommended'
      get 'user_stretches/completed', to: 'user_stretches#completed'
      post 'user_stretches/mark_completed', to: 'user_stretches#mark_completed'
    end
  end

  # WebSocket用のマウントポイント
  mount ActionCable.server => '/ws'
end
