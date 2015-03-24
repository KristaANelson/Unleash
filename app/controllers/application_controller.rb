class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_dog, :matches, :states

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_dog
    if Dog.where(id: session[:dog]).count == 1
      @current_dog = Dog.find(session[:dog])
    else
      @current_dog = current_user.dogs.first
    end
  end

  def authorize!
    redirect_to root_path unless current_user
  end

  def matches
    @matches = Observation.matches(current_dog)
  end
end
