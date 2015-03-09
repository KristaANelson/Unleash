class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_or_create_from_auth(auth)
    if @user
      session[:user_id] = @user.id
      redirect_to new_dog_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
