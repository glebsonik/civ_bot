require 'telegram/bot'

class Telegram::WebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  REDIRECT_PATHS = {
    '✍' => { command: :nickname!, mode: :context, message: 'Веди свій Steam нік будь ласка' },
    '🔔' => { command: :enable_notifications!, mode: :hit },
    '🔕' => { command: :silent!, mode: :hit }
  }.freeze

  def start!
    user = User.find_or_initialize_by(username: chat['username'])

    user.chat_name = Encryptor::Encryptor.encrypt(chat['id'])
    if user.save
      respond_with :message,
                   text: "Привіт, #{chat['first_name']} тебе успішно зареєстровано в системі",
                   reply_markup: {
                     remove_keyboard: true
                   }
      respond_with :message, text: 'Веди свій Steam нік будь ласка'
      save_context :nickname!
    else
      respond_with :message, text: "На жаль трапилась помилка: \n#{user.errors.full_messages.join("\n")}"
    end
  end

  def nickname!(nickname = '')
    if nickname.blank?
      respond_with :message, text: 'Твій нік не може бути порожнім'
    else
      User.find_by(username: chat['username']).update!(steam_name: nickname)
      respond_with :message, parse_mode: 'markdown', text: "Нік *#{nickname}* збережено",
                   reply_markup: keyboard_default_markup
    end
  end

  def silent!(*)
    User.find_by(username: chat['username']).update!(silent_mode: true)
    respond_with :message, text: 'Тепер ти не отримуєш сповіщення', reply_markup: keyboard_default_markup
  end

  def enable_notifications!(*)
    User.find_by(username: chat['username']).update!(silent_mode: false)
    respond_with :message, text: 'Ти знов отримуєш сповіщення', reply_markup: keyboard_default_markup
  end

  def message(msg = nil)
    return unless msg && REDIRECT_PATHS.keys.include?(msg['text'][0])

    command_entity = REDIRECT_PATHS[msg['text'][0]]
    case command_entity[:mode]
    when :context
      respond_with(:message, text: command_entity[:message]) if command_entity[:message]
      save_context command_entity[:command]
    when :hit
      send(command_entity[:command])
    end
  end

  def keyboard_default_markup
    notification_mode = User.find_by(username: chat['username']).silent_mode ? '🔔 Увімкнути сповіщення' : '🔕 Вимкнути сповіщення'
    {
      keyboard: [['✍️ Змінити нік'], [notification_mode]],
      resize_keyboard: true,
      input_field_placeholder: 'Sho?'
    }
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
