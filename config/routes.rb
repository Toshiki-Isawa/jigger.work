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
    
    resources :end_users, only:[:edit,:show,:update] do
      member do
        patch :withdraw
      end
      resource :relationships, only: [:create, :destroy]
    end
    
    resources :cocktails do
      resource :favorites, only: [:create, :destroy]
      collection do
        post :search
      end
    end
    
    resources :ingredients, only:[:index,:show]
  end

  # Admin側ルーティング
  devise_scope :admins do
    devise_for :admins, controllers: {
      sessions: 'admins/devise/sessions',
    }
  end

  namespace :admins do
    get 'homes/top' => 'homes#top', as:'top'
    resources :end_users, only: [:index, :edit, :show, :update] do
      member do
        patch :withdraw
        patch :unfreeze
      end
    end
    resources :cocktails do
      collection do
        get :get_api_cocktails
        get :get_cocktail_image
        post :search
      end
    end
    resources :ingredients, only: [:index, :create, :destroy]
  end
    


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
