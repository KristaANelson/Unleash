class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    require 'pry'; binding.pry
    @user = User.find_or_create_from_auth(auth)
    if @user
      session[:user_id] = @user.id
      redirect_after_login
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def redirect_after_login
    if current_user.dogs.count > 0
      redirect_to user_path(current_user)
    else
      redirect_to new_dog_path
    end
  end
end
