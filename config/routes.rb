Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users
  get 'hello_world', to: 'hello_world#index'
  # root to: 'hello_world#index'

  namespace :admin do
    resources :users
    resources :roles

    resources :snort_rules do
      collection do
        get :restart_snort
        get :save_rule
      end

      member do
        get :active_rule
        get :deactive_rule
      end
    end

    resources :events
  end

  get '/', to: 'admin/dashboards#dashboard'

  root to: 'admin/dashboards#index'
end
