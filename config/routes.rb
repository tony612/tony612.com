Tony612Com::Application.routes.draw do
  devise_for :admins

  resources :posts, except: [:show]
  match "posts/:title" => "posts#show", via: :get
  match "about" => "admins#show"
  root to: "posts#index"
  match "life" => "posts#life"
  match "tech" => "posts#tech"
end
