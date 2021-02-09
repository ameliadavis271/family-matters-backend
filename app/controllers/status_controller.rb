class StatusController < ApplicationController
  before_action :authenticate_user

  def index
    render json: { message: "Logged In"}
  end

  def user
    render json: { user: current_user.email }
  end

  def family_id
    @family = current_user.family
    render json: { familyid: @family.family_id }
  end
end
