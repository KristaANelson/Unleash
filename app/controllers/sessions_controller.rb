class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth(request.env["omniauth.auth"])
    session[:user_id] = @user.id
    session[:dog_id] = @user.dogs.first if @user.dogs
    redirect_after_login
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def redirect_after_login
    return root_path if !current_user
    return redirect_to new_dog_path if current_user.dogs.empty?
    redirect_to new_observation_path
  end
end
