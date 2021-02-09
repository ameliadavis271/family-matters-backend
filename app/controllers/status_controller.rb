class StatusController < ApplicationController
  before_action :authenticate_user

  def index
    @family = current_user.family
    render json: { familyid: @family.family_id }
  end

  def user
    render json: { user: current_user.email }
  end
end
