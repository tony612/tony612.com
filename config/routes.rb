Tony612Com::Application.routes.draw do
  devise_for :admins

  resources :posts
  resources :admins, :only => [:show]
  root to: "posts#index"
end
