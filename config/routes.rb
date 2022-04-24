Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'static_pages#top'
  post 'callback' => 'users#callback'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider'=> 'oauths#oauth', :as => :auth_at_provider
  delete 'logout', to: 'oauths#destroy', :as => :logout
  get 'circle/:id/events' => 'events#circle_events', :as => :circle_event_list
  get 'circle/:uuid/affiliations' => 'affiliations#new', :as => :new_circle_affiliation
  post 'circle/:uuid/affiliations' => 'affiliations#create', :as => :circle_affiliation
  get 'event/:id/shuffle' => 'events#shuffle', :as => :shuffle
  get 'circle/:circle_id/affiliation/:id/assign' => 'affiliations#circle_admin_assign', :as => :circle_admin_assign
  get 'circle/:circle_id/affiliation/:id/retire' => 'affiliations#circle_admin_retire', :as => :circle_admin_retire

  resources :circles do
    resources :events, only: %i[new create] do
      resources :attendances, only: %i[new create update]
      resource :matches, only: %i[create show edit update destroy show]
    end
    resource :affiliation, only: %i[edit update]
    resources :affiliations, only: %i[index]
    resources :circle_roles, only: %i[new create destroy]
  end
  resources :events, only: %i[index show edit update show destroy] do
    resource :match_results, only: %i[create]
  end
  resource :mypage, only: %i[show edit update]
  resources :affiliations, only: %i[show]
end
