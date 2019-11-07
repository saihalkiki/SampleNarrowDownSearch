Rails.application.routes.draw do
  resources :events do
    get :search, on: :collection
  end

  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
