Rails.application.routes.draw do
  root to: "welcome_users#index"
  get 'welcome_users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
