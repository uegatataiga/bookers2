Rails.application.routes.draw do
devise_for :users
root to: "homes#top"
get "/home/about" => "homes#about", as: "about"
resources :users, only: [:show, :edit, :create, :index, :update]
resources :books, only: [:new, :index, :show, :create, :destroy, :edit, :update]
end
