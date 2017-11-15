Rails.application.routes.draw do

	devise_for :users, controllers: {
        registrations: 'users/registrations'
	} 

	root to: 'pages#index'

	resources :menus
	get 'cooks/:id/menu_show', to: 'cooks#menu_show', as:'menu_show'
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
