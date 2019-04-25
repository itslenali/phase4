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
  resources :partials
  resources :layouts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'home#home' 
   get 'signup' => 'users#new', :as => :signup
   get 'login' => 'sessions#new', :as => :login
   get 'login', :controller => 'sessions', :action => 'new'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => 'sessions#destroy', :as => :logout  
  end
  
  # # Semi-static page routes
   get 'home' => 'home#home', as: :home
   
   #FOR EMPLOYEES
   get 'home/employee_profile' => 'home#employee_profile', :as => :employee_profile
   get 'home/employee_dashboard' => 'home#employee_dashboard', :as => :employee_dashboard
   get 'home/manage_shifts' => 'home#manage_shifts', :as => :myshifts
   get 'home/account' => 'home#account', :as => :account

   
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  get 'home/manager_home' => 'home#manager_home', :as => :manager_home
  get 'home/past_shifts' => 'home#past_shifts', :as => :past_shifts
  get 'home/future_shifts' => 'home#future_shifts', :as => :future_shifts
  get 'home/employee_shifts' => 'home#employee_shifts', :as => :employee_shifts
   
  get 'home/new_shifts' => 'home#new_shifts', :as => :new_shifts
  get 'home/admin_home' => 'home#admin_home', :as => :admin_home
  get 'shift/incomplete_shifts' => 'shifts#incomplete_shifts', :as => :incomplete_shifts

  patch 'start_shift/:id' => 'shifts#start_shift', as: :start_shift
  patch 'end_shift/:id' => 'shifts#end_shift', as: :end_shift

  
  # Set the root url
end
