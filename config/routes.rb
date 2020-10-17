Rails.application.routes.draw do
  root 'public/homes#top'
  get '/search' => 'search#search'
  get 'contacts' => 'contacts#index'
  get 'contacts/confirm' => redirect("/contacts")
  get 'contacts/thanks' => redirect("/contacts")
  post 'contacts/confirm' => 'contacts#confirm'
  post 'contacts/thanks' => 'contacts#thanks'
  resources :rooms
  
  # Public側ルーティング
  devise_for :end_users, controllers: {
    registrations: 'public/devise/registrations',
    sessions:'public/devise/sessions',
    omniauth_callbacks: 'public/devise/omniauth_callbacks'
  }
  devise_scope :end_user do
    post 'guest_sign_in' => 'public/devise/sessions#new_guest'
  end

  namespace :public do
    get 'homes/top' => 'homes#top', as: 'top'
    get 'homes/terms' => 'homes#terms', as: 'terms'
    get 'homes/policy' => 'homes#policy', as: 'policy'
    
    resources :end_users, only:[:edit,:show,:update] do
      member do
        patch :withdraw
      end
      resource :relationships, only: [:create, :destroy]
    end
    
    resources :cocktails do
      resource :favorites, only: [:create, :destroy]
      resources :rates, only: [:create, :destroy]
      post :search, on: :collection
      post :multiple_search, on: :collection
      get :ranking, on: :collection
    end
    
    resources :ingredients, only:[:index] do
      post :search, on: :collection
    end
  end

  # Admin側ルーティング
  devise_scope :admins do
    devise_for :admins, controllers: {
      sessions: 'admins/devise/sessions',
    }
  end

  namespace :admins do
    get 'homes/top' => 'homes#top', as:'top'
    resources :end_users, only: [:index, :show] do
      member do
        patch :withdraw
        patch :unfreeze
      end
    end
    resources :cocktails do
      collection do
        get :get_api_cocktails
        post :search
        get :similar_cocktail
      end
    end
    resources :ingredients, only: [:index, :create, :update, :destroy] do
      post :search, on: :collection
    end
  end
    
end
