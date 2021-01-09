Rails.application.routes.draw do
  get 'customers/index'
  devise_for :customers
  
  root to: "customers#index"

end
