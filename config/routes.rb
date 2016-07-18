Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  post '/import', to: 'import#handle'

  root to: "home#index"

  scope '/admin' do
    devise_for :users
  end

  resources :cars, only: [:index, :show], path: 'autos' do
    get :like
    get 'finance_car/:car_id/:type', to: 'cars#finance_car', as: :finance_car
    collection do
      get :favourites
      get 'compare/:car_1_id/:car_2_id', to: 'cars#compare', as: :compare_2
      get 'compare/:car_1_id/:car_2_id/:car_3_id', to: 'cars#compare', as: :compare_3
      get :nieuw_binnen, to: 'cars#new_cars', as: :new_cars
    end
  end

  resources :brands do
    get :cars
    resources :models, only: [] do
      get :cars
    end
  end

  resources :car_sale_requests, only: [:create]

  resources :appointment_requests, only: [:create]

  resources :reviews

  resources :vacancies, only: [:index, :show], path: 'vacatures'

  resources :link_partners, only: [:index]

  ## route static links after normal resources to prevent conflicts
  get 'contact', to: 'static_pages#contact'
  get 'financieringen', to: 'static_pages#financieringen'
  get 'particuliere_financieringen', to: 'static_pages#particuliere_financieringen'
  get 'zakelijke_financieringen', to: 'static_pages#zakelijke_financieringen'
  get '50_50_deals', to: 'static_pages#deals_50_50', as: :deal_50_50
  get 'disclaimer', to: 'static_pages#disclaimer'
  get 'site_map', to: 'static_pages#site_map'

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

    resources :settings, only: [:index, :edit, :update]

    resources :vacancies

    resources :reviews, only: [:index, :update]

    resources :car_sale_requests, only: [:index, :destroy]

    resources :appointment_requests, only: [:index, :destroy]

    resources :pages do
      collection do
        get '/new/:template_id', to: 'pages#new', as: :new_page_with_template
      end
    end
  end

  resources Phrasing.route, as: 'phrasing_phrases', controller: 'phrasing_phrases', only: [:index, :edit, :update, :destroy] do
    collection do
      get 'help'
      get 'import_export'
      get 'sync'
      get 'download'
      post 'upload'
      put 'remote_update_phrase'
    end
  end
  resources :phrasing_phrase_versions, as: 'phrasing_phrase_versions', controller: 'phrasing_phrase_versions', only: [:destroy]

  resources :pages, only: [:show], path: '/'

end
