Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  post '/import', to: 'import#handle'

  root to: "home#index"

  scope '/admin' do
    devise_for :users
  end

  resources :cars, only: [:index, :show], path: 'autos' do
    get :like
    collection do
      get 'compare/:car_1_id/:car_2_id', to: 'cars#compare', as: :compare_2
      get 'compare/:car_1_id/:car_2_id/:car_3_id', to: 'cars#compare', as: :compare_3
    end
  end

  resources :brands do
    get :cars
    resources :models, only: [] do
      get :cars
    end
  end

  resources :vacancies, only: [:index, :show], path: 'vacatures'

  resources :link_partners, only: [:index]

  ## route static links after normal resources to prevent conflicts
  get 'contact', to: 'static_pages#contact'
  get 'financieringen', to: 'static_pages#financieringen'
  get 'particuliere_financieringen', to: 'static_pages#particuliere_financieringen'
  get 'zakelijke_financieringen', to: 'static_pages#zakelijke_financieringen'
  get '50_50_deals', to: 'static_pages#deals_50_50', as: :deal_50_50
  get 'disclaimer', to: 'static_pages#disclaimer'

  namespace :admin do

    root 'admin#home'

    resources :cars do
      collection do
        get :search
        get :best_day_deals
      end
      get :edit_car_card
      post :car_card
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

    resources :sliders, except: [:new, :create] do
      resources :slides, only: [:index]
    end

    resources :slides, except: [:index] do
      collection do
        get '/new/:template_id/:slider_id', to: 'slides#new', as: :new_slide_with_template
        post :update_row_order
      end
    end

    resources :menus, except: [:new, :create] do
      resources :menu_items, only: [:index, :new]
    end

    resources :menu_items, except: [:index] do
      collection do
        post :update_row_order
      end
    end

    resources :marquee_items

    resources :link_partners

    resources :admin do
      collection do
        get :home
      end
    end

    resources :vacancies

    resources :pages do
      collection do
        get '/new/:template_id', to: 'pages#new', as: :new_page_with_template
      end
    end
  end

  resources :pages, only: [:show], path: '/'

end
