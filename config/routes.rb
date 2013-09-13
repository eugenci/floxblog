Foxblog::Application.routes.draw do

  root to: 'posts#index'

  devise_for :user
  resources :posts

end
