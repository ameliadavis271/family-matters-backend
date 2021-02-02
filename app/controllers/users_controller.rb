class UsersController < ApplicationController
  
  def create
    @user = User.create(user_params)
    if @user.save
      token = Knock::AuthToken.new(payload: { sub: @user.id }).token
      render json: {
        email: @user.email,
        jwt: token
      }, status: 201
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def sign_in
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      token = Knock::AuthToken.new(payload: { sub: @user.id }).token
      render json: {
        email: @user.email,
        jwt: token
      }, status: 200
    else
      render json: {error: "Incorrect email or password"}, status: 404
    end
  end
  
  private
  def user_params
    params.permit(:email, :first_name, :last_name, :password, :password_confirmation, :family_id)
  end
end
