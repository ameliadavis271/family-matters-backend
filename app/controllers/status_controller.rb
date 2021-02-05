class StatusController < ApplicationController
  before_action :authenticate_user

  def index
    render json: { message: "Logged In"}
  end

  def user
    render json: { user: current_user.email }
  end
end
