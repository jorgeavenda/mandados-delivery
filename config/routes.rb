Rails.application.routes.draw do
  get 'how_to_buy/instructions'
  get 'how_to_buy/condition'

  resources :buyers
  get 'buyers/welcome'

  post '/admin/pay_offs/add_cuadre', to: 'admin/pay_offs#add_cuadre', as: :admin_pay_offs_add_cuadre

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users,
             path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register/:type'}
  #controllers: {sessions: 'user/sessions', registrations: 'user/registrations'},

  devise_scope :user do
    get '/users/login/:type', to: 'user/sessions#new', as: :new_user_type_session
  end

  resources :shopping_carts do
    collection do
      get :for_tomorrow
      get :previous
    end
  end

  post '/shopping_carts/:id/remove_item/:item_id', to: 'shopping_carts#remove_item', as: :remove_item_cart
  post '/shopping_carts/:id/add_item', to: 'shopping_carts#add_item', as: :add_item_cart

  post '/shopping_carts/:id/save_list', to: 'shopping_carts#save_list', as: :save_list

  get '/shopping_carts/for_tomorrow/:id', to: 'shopping_carts#show_for_tomorrow', as: :show_for_tomorrow
  get '/shopping_carts/previous/:id', to: 'shopping_carts#show_previous', as: :show_previous

  get "commanded_detail" => 'main#commanded_detail'
  get "no_active" => 'main#no_active'

  root to: 'main#index'
end