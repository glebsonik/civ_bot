class GameHookController < ApplicationController
  def create_message
    user = User.find_by(steam_name: params["value2"])
    payload = {
      chat_id: Encryptor::Encryptor.decrypt(user.chat_name),
      text: "🟢 Ваша черга #{user.steam_name}\n\nГра: #{params["value1"]}\nПоточний ход: #{params["value3"]}"
    }

    uri = URI.parse("https://api.telegram.org/bot#{Rails.application.credentials.telegram[:bot]}/sendMessage")
    Net::HTTP.post_form(uri, payload)

    respond_to do |format|
      format.json { render json: params.to_json }
    end
  end
end
