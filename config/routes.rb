StoryModels::Application.routes.draw do
  
  resources :users
  
  root :to => "stories#index"

  get "users/new"
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  get "stories", controller: "stories", action: "index", as: :stories
  post "stories/:id", controller: "stories", action: "create"
  post "stories/:id/submission", controller: "stories", action: "create", as: :submissions
  

  get "stories/new", controller: "stories", action: "new", as: :new_story
  get "stories/:id", controller: "stories", action: "show", as: :story
  put "/stories/:id/submission", controller: "stories", action: "update"
end
