Rails.application.routes.draw do
  get 'how_to_buy/instructions'
  get 'how_to_buy/condition'

  resources :buyers do
    member do
      get :active
      get :edit_register
      patch :update_register
    end
    collection do
      get :msg_edit
    end
  end

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
      get :deliveries
      get :show_deliveries_shopping_cart
    end
  end

  post '/shopping_carts/:id/remove_item/:item_id', to: 'shopping_carts#remove_item', as: :remove_item_cart
  post '/shopping_carts/:id/add_item', to: 'shopping_carts#add_item', as: :add_item_cart

  post '/shopping_carts/:id/save_list', to: 'shopping_carts#save_list', as: :save_list

  get '/shopping_carts/for_tomorrow/:id', to: 'shopping_carts#show_for_tomorrow', as: :show_for_tomorrow
  get '/shopping_carts/deliveries/:id', to: 'shopping_carts#deliveries_shopping_cart', as: :deliveries_shopping_cart
  get '/shopping_carts/show_deliveries_shopping_cart/:id', to: 'shopping_carts#show_deliveries_shopping_cart', as: :show_deliveries_shopping_cart

  get "commanded_detail" => 'main#commanded_detail'
  get "no_active" => 'main#no_active'

  root to: 'main#index'
end