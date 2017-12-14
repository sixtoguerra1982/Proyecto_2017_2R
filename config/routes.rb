Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

   resources :menus, only: [:index, :new, :edit, :update, :create, :destroy] do
     collection do
       get 'carousel'
     end
     post :update_date
     resources :orders, only: [:index, :create]
   end

  resources :cooks, only: [:show, :edit, :update] do
    resources :comments, only: [:create, :update, :destroy, :show]
  end

  resources :orders, only: [:index, :destroy] do
    collection do
      get 'clean'
    end
  end

  root to: 'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
