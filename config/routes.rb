Tony612Com::Application.routes.draw do
  resources :posts, only: [:index, :show]

  root to: "posts#index"
end
