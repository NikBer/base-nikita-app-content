# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"

  mount ShopifyApp::Engine, at: "/api"
  get "/api", to: redirect(path: "/") # Needed because our engine root is /api but that breaks FE routing

  # If you are adding routes outside of the /api path, remember to also add a proxy rule for
  # them in web/frontend/vite.config.js

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/api/products/count", to: "products#count"
  get "/api/products/create", to: "products#create"

  # Any other routes will just render the react app
  match "*path" => "home#index", via: [:get, :post]

  post '/api/trigger_blog_id_fetcher', to: 'jobs#trigger_blog_id_fetcher'
  post '/api/trigger_blog_post_job', to: 'jobs#trigger_blog_post_job'
  post '/api/trigger_fetch_shopify_data_worker', to: 'jobs#trigger_fetch_shopify_data_worker'

end
