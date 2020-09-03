Rails.application.routes.draw do
  root 'public/homes#top'

  # EndUser側ルーティング
  devise_scope :public do
    devise_for :end_users, controllers: {
      registrations: 'public/devise/registrations',
      passwords:'public/devise/passwords',
      sessions:'public/devise/sessions',
    }
  end


  namespace :public do
    get 'homes/top' => 'homes#top', as: 'end_user_top'
    get 'homes/about' => 'homes#about', as: 'end_user_about'
    get 'homes/terms' => 'homes#terms', as: 'end_user_terms'
    
    resource :end_users, only:[:edit,:show,:update] do
      member do
        get :unsubscribe
        put :withdraw
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
    
    resources :cocktails do
      collection do
        post 'search'
      end
    end
    
    resources :ingredients, only:[:index,:show]
  end

  # Admin側ルーティング
  devise_scope :admins do
    devise_for :admins, controllers: {
      registrations: 'admins/devise/registrations',
      passwords: 'admins/devise/passwords',
      sessions: 'admins/devise/sessions',
    }
  end

  namespace :admins do
    get 'homes/top' => 'homes#top', as:'top'
    resources :end_users, only: [:index, :edit, :show, :update]
    resources :cocktails
    resources :ingredients, only: [:index, :create, :destroy]
  end
    


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
