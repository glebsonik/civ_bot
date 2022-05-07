Rails.application.routes.draw do
  post 'game_hook/create_message'
  root to: "welcome_users#show"

  resource :welcome_users, only: [:show]

  post 'create_message', to: 'welcome_users#create_message', as: :create_message
  telegram_webhook Telegram::WebhookController
end
