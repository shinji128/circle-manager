Rails.application.routes.draw do
  root 'static_pages#top'
  post 'callback' => 'users#callback'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider'=> 'oauths#oauth', :as => :auth_at_provider
  get 'circle/:id/member' => 'circles#circle_member', :as => :member
  resources :circles, only: %i[index new create show] do
    resources :affiliations, only: %i[new create]
    resources :events, only: %i[new create show] do
      resources :attendances, only: %i[new create]
    end
    resources :circle_roles, only: %i[new create]
  end
  resource :mypage, only: %i[show]
end
