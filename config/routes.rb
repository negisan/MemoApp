Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  resources :memos
  root 'memos#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
