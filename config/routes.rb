Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  
  root to: "top#index"
  resources :reservations
  resources :staffs, only: :index
  resources :customers, only: :show
end
