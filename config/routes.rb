Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  
  get 'customers/index'
  root to: "staffs#index"
  resources :reservations, only: [:new, :create, :index, :show, :edit]
  resources :staffs, only: [:index]
end
