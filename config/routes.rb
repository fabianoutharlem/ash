Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  post '/import', to: 'import#handle'

  root to: "home#index"

  scope '/admin' do
    devise_for :users
  end

  resources :cars do
    get :like
  end

  resources :brands do
    get :cars
    resources :models, only: [] do
      get :cars
    end
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

    resources :sliders do
      resources :slides, only: [:index]
    end

    resources :slides, except: [:index] do
      collection do
        get '/new/:template_id/:slider_id', to: 'slides#new', as: :new_slide_with_template
        post :update_row_order
      end
    end

    resources :marquee_items

    resources :admin do
      collection do
        get :home
      end
    end
  end

end
