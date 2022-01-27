Rails.application.routes.draw do
  root 'static_pages#top'
  post 'callback' => 'users#callback'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  resources :users
  resources :circles
end
