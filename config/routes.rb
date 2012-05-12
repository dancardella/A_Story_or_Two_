StoryModels::Application.routes.draw do
  
  get "users/new"
  match '/signup', to: 'users#new'

  get "stories", controller: "story", action: "index", as: :stories
  post "stories/:id", controller: "story", action: "create"
  post "stories/:id/submission", controller: "story", action: "create", as: :submissions
  

  get "stories/new", controller: "story", action: "new", as: :new_story
  get "stories/:id", controller: "story", action: "show", as: :story
  put "/stories/:id/submission", controller: "story", action: "update"
end
