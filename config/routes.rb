Tony612Com::Application.routes.draw do

  resources :posts
  root to: "posts#index"
  get "life" => "posts#life"
  get "tech" => "posts#tech"
end
