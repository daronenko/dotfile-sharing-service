Rails.application.routes.draw do
  resources :dotfiles
  root 'home#index'
  get 'home/about'
end
