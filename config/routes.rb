Rails.application.routes.draw do
  devise_for :users, :skip => :registration
  resources :service_types
  resources :parcels
  resources :addresses
  resources :users
  root to: 'parcels#index'
  get '/search', to: 'search#index'
  get '/report', to: 'parcels#report', as: :parcel_report
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
