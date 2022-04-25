class Telegram::WebhookController < Telegram::Bot::UpdatesController
  def start!
    respond_with :message, text: "Ti shto summoneeeer!"
  end
end
