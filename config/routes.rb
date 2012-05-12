StoryModels::Application.routes.draw do
  
  resources :users
  
  get "users/new"
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  get "stories", controller: "story", action: "index", as: :stories
  post "stories/:id", controller: "story", action: "create"
  post "stories/:id/submission", controller: "story", action: "create", as: :submissions
  

  get "stories/new", controller: "story", action: "new", as: :new_story
  get "stories/:id", controller: "story", action: "show", as: :story
  put "/stories/:id/submission", controller: "story", action: "update"
end
