Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
  get 'initial', to: 'games#initial'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
