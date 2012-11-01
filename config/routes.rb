Tony612Com::Application.routes.draw do
  devise_for :admins

  resources :posts
  match "about" => "admins#show"
  root to: "posts#index"
end
