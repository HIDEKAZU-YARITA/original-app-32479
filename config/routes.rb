Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  
  # get 'top/index'
  root to: "top#index"
  resources :reservations
  resources :staffs, only: [:index]
end
