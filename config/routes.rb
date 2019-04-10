Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  resources :item_types, only: %i[index new create edit update]
  resources :items do
    get 'my', on: :collection
    resources :item_founds, only: [:create]
  end

  resources :item_founds, only: [:show]

  get 'search', to: 'items#search'
  
  resources :reports
  

end
