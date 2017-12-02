Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

   resources :menus do
     post :update_date
     resources :orders, only: [:index, :create]
   end

  resources :cooks do
    resources :comments, only: [:create, :destroy]
  end

  resources :orders, only: :index do
    collection do
      get 'clean'
    end
  end

  root to: 'pages#index'
  get 'cooks/:id/menu_show', to: 'cooks#menu_show', as:'menu_show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
