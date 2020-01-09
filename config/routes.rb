Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  get "/map", to: "pages#map"
  namespace 'api', defaults: {format: :json} do
    resources :towers, only: [:create, :index]
    resources :transmitters, only: [:create, :index]
    resources :succesful_downloads, only: [:index]
    resources :failed_downloads, only: [:index]
    resources :antenna_search_urls, only: [:create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/*path' => 'pages#homepage'
  root to: 'pages#homepage'
end
