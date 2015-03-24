class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action  :change_dog

  helper_method :current_user, :current_dog, :matches, :states

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def change_dog
    session[:dog] = params[:dog_id] if params[:dog_id]
  end

  def current_dog
    @current_dog = Dog.find(session[:dog]) if session[:user_id]
  end

  def authorize!
    redirect_to root_path unless current_user
  end

  def matches
    @matches = Observation.matches(current_dog)
  end
end
