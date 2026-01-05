Rails.application.routes.draw do
  # get "/posts", to: "posts#index"

  # get "/posts/new", to: "posts#new"
  # post "/posts", to: "posts#create"

  # get "/posts/:id", to: "posts#show"

  # get "/posts/:id/edit", to: "posts#edit"
  # patch "/posts/:id", to: "posts#update"
  # put "/posts/:id", to: "posts#update"

  # delete "/posts/:id", to: "posts#destroy"
  resources :posts
end
