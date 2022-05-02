require "uri"
require "net/http"

class WelcomeUsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
  end

  def create_message
    payload = {
      chat_id: "331524680",
      text: params.to_unsafe_h.to_s
    }

    response = Net::HTTP.post_form(URI.parse("https://api.telegram.org/bot#{Rails.application.credentials.telegram[:bot]}/sendMessage"), payload)
    p response

    respond_to do |format|
      format.json  { render json: params.to_json }
      format.html { redirect_to :show }
    end
  end
end
