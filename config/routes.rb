Rails.application.routes.draw do
  resources :users
  resources :store_flavors
  resources :shifts
  resources :shift_jobs
  resources :jobs
  resources :flavors
  resources :stores
  resources :employees
  resources :assignments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'application#application'
end
