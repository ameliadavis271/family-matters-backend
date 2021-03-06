class UsersController < ApplicationController
  
  def create
    # ensures user has a family_id
    if user_params[:family_id] == ""
      params[:user][:family_id] = create_family
    else
      params[:user][:family_id] = (Family.where(family_id: user_params[:family_id])).ids.first
    end
    @user = User.create(user_params)
    if @user.save
      token = Knock::AuthToken.new(payload: { sub: @user.id }).token
      render json: {
        jwt: token
      }, status: 201
    else
      puts @user.errors.messages
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def sign_in
    # find and log in user based on params in database
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
    params.require(:user).permit(:family_id, :email, :first_name, :last_name, :password, :password_confirmation)
  end

  def gen_family_code
    # generates a 7 digit family code
    return SecureRandom.uuid[0..7]
  end

  def create_family
    # creates new family
    @family = Family.create(name: user_params[:last_name], family_id: gen_family_code)
    if @family.errors.any?
      render @family.errors, status: :unprocessable_entity
    end
    return @family.id
  end

  def set_family
    #sets family
    @family = Family.where(family_id: user_params[:family_id])
  end
end
