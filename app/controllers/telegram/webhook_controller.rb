require 'telegram/bot'

class Telegram::WebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start!(*args)
    user = User.new
    user.username = chat["username"]

    crypt_key = Rails.application.credentials.user_chat_key
    user.chat_name = ActiveSupport::MessageEncryptor.new(crypt_key).encrypt_and_sign(chat["id"])

    if user.save
      respond_with :message, text: "Привіт, #{chat['first_name']} тебе успішно зареєстровано в системі"
    else
      respond_with :message, text: "На жаль трапилась помилка: \n#{user.errors.full_messages.join("\n")}"
    end
    # respond_with :message, text: "id: #{Message.last(2)[0].id} Body: #{Message.last(2)[0].body}"
    # respond_with :message, text: "id: #{Message.last(2)[1].id} Body: #{Message.last(2)[1].body}"
    # respond_with :message, text: 'Выбери опцию. Пока есть только єта', reply_markup: {
    #   keyboard: [['/abobus']],
    #   resize_keyboard: true,
    #   one_time_keyboard: true,
    #   input_field_placeholder: 'Sho?'
    # }
  end

  # def abobus!(value = nil, *)
  #   if value
  #     respond_with :message, text: 'Да, ты действительно сосал кіту'
  #   else
  #     save_context :abobus!
  #     respond_with :message, text: 'Ты сосал кіту?', reply_markup: {
  #       keyboard: [['Да, Я сосал кіту']],
  #       resize_keyboard: true,
  #       one_time_keyboard: true,
  #       selective: true,
  #       input_field_placeholder: 'Sho?'
  #     }
  #   end
  # end
end
