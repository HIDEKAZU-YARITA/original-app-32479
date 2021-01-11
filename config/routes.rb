Rails.application.routes.draw do
  get 'customers/index'
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  
  root to: "customers#index"
end
