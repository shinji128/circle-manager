Rails.application.routes.draw do
  root 'static_pages#top'
  post 'callback' => 'users#callback'
end
