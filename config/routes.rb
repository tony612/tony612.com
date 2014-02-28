Tony612Com::Application.routes.draw do

  resources :posts
  root to: "posts#index"
  get "life" => "posts#life"
  get "tech" => "posts#tech"
  get "login" => 'sessions#new', as: 'login'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/sessions/destroy' => 'sessions#destroy', as: 'destroy_sessions'
end
