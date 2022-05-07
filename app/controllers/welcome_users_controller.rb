require "uri"
require "net/http"

class WelcomeUsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
  end
end
