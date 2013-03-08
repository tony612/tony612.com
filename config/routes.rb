Tony612Com::Application.routes.draw do
  devise_for :admins

  resources :posts
  get "about" => "admins#show"
  root to: "posts#index"
  get "life" => "posts#life"
  get "tech" => "posts#tech"
end
