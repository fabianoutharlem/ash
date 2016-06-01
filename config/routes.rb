Rails.application.routes.draw do

  post '/import', to: 'import#handle'

  root to: "home#index"

  scope '/admin' do
    devise_for :users
  end

  namespace :admin do

    root 'admin#home'

    resources :cars do
      collection do
        get :search
        get :best_day_deals
      end
    end

    resources :brands do
      post :update_row_order, on: :collection
    end

    resources :admin do
      collection do
        get :home
      end
    end
  end

end
