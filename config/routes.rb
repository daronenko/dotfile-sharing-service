Rails.application.routes.draw do
scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: { registrations: 'users/registrations' }

    devise_scope :user do  
      get '/users/sign_out' => 'devise/sessions#destroy'     
    end

    resources :dotfiles

    resources :dotfiles do
      member do
        patch :vote
        patch :bookmark
      end
    end

    root 'home#index'
    get 'bookmarks/index'

    resources :users, only: [:show]
  end
end
