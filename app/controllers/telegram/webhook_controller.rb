require 'telegram/bot'

class Telegram::WebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start!(*)
    respond_with :message, text: 'Ti shot summoner?'
    respond_with :message, text: 'Выбери опцию. Пока есть только єта', reply_markup: {
      keyboard: [['/abobus']],
      resize_keyboard: true,
      one_time_keyboard: true,
      input_field_placeholder: 'Sho?'
    }
  end

  def abobus!(value = nil, *)
    if value
      respond_with :message, text: 'Да, ты действительно сосал кіту'
    else
      save_context :abobus!
      respond_with :message, text: 'Ты сосал кіту?', reply_markup: {
        keyboard: [['Да, Я сосал кіту']],
        resize_keyboard: true,
        one_time_keyboard: true,
        selective: true,
        input_field_placeholder: 'Sho?'
      }
    end
  end
end
