class WelcomeUsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
  end

  def create_message
    message = params.require(:message)
    message = Message.create!(body: message[:body])

    respond_to do |format|
      format.json  { render json: message.to_json }
      format.html { redirect_to :show }
    end
  end
end
