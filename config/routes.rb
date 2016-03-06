Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users,
             controllers: {sessions: 'user/sessions', registrations: 'user/registrations'},
             path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register/:type'}

  devise_scope :user do
    get '/users/login/:type', to: 'user/sessions#new', as: :new_user_type_session
  end

  root to: 'main#index'
end