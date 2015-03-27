class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action  :change_dog

  helper_method :current_user, :current_dog, :matches, :states

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def change_dog
    session[:dog_id] = params[:change_dog] if params[:change_dog]
  end

  def current_dog
    @current_dog ||= current_user.dogs.first if current_user.dogs.first
  end

  def authorize!
    redirect_to root_path unless current_user
  end

  def matches
    @matches = Observation.matches(current_dog)
  end
end
