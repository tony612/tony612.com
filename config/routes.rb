Tony612Com::Application.routes.draw do

  resources :posts
  root to: "posts#index"
  get "login" => 'sessions#new', as: 'login'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/sessions/destroy' => 'sessions#destroy', as: 'destroy_sessions'

  # FIXME: warden doesn't need this route. But test needs.
  get 'unauthenticated' => 'sessions#unauthenticated'
end
