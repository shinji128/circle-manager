Rails.application.routes.draw do
  root 'static_pages#top'
  post 'callback' => 'users#callback'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider'=> 'oauths#oauth', :as => :auth_at_provider
  get 'circle/:id/member' => 'circles#circle_member', :as => :member
  get 'circle/:id/member_edit/:id' => 'circles#member_edit', :as => :member_edit
  get 'circle/:id/events' => 'events#circle_events', :as => :circle_event_list
  get 'circle/:uuid/affiliations' => 'affiliations#new', :as => :new_circle_affiliation
  post 'circle/:uuid/affiliations' => 'affiliations#create', :as => :circle_affiliation
  get 'event/:id/shuffle' => 'events#shuffle', :as => :shuffle
  get 'event/:id/matchdecide' => 'match_results#match_decide', :as => :match_decide

  resources :circles do
    resources :events, only: %i[new create] do
      resources :attendances, only: %i[new create update]
      resource :matches, only: %i[create show edit update destroy show]
    end
    resource :affiliation, only: %i[edit update]
    resources :circle_roles, only: %i[new create destroy]
  end
  resources :events, only: %i[index show edit update show destroy]
  resource :mypage, only: %i[show edit update]
  resources :affiliations, only: %i[show]
end
