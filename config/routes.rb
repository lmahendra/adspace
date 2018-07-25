Rails.application.routes.draw do
  resources :bids do
    collection do 
      get :mybids
    end
  end
  resources :slots do
  	collection do
  		get :available
      get :available_partial
      get :myslots
  	end
  end
  get "/home" => "home#index"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get "/sign_out" => "devise/sessions#destroy"
end
