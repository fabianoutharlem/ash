Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
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

    resources :newsletters do
      get :prepare_for_send
      post :send_newsletter
      get :preview
      collection do
        get '/new/:template_id', to: 'newsletters#new', as: :new_newsletter_with_template
      end
    end

    resources :admin do
      collection do
        get :home
      end
    end
  end

end
