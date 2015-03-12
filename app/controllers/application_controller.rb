class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :matches

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    redirect_to root_path unless current_user
  end

  def matches
    likes = Observation.where(observer_id: current_user.dogs.first.id, liked: true).map {|like| like.observed_id }
    liked = Observation.where(observed_id: current_user.dogs.first.id, liked: true).map {|like| like.observer_id }
    match_ids = likes.select {|like| liked.include?(like) }
    @matches = Dog.where(id: match_ids)
  end
end
