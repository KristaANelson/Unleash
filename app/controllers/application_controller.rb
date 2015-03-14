class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_dog, :matches, :states

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def states
    @states = %w(State AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
  end

  def current_dog
    @current_dog = current_user.dogs.first
  end

  def authorize!
    redirect_to root_path unless current_user
  end

  def matches
    likes = Observation.likes(current_dog.id).map(&:observed_id)
    liked = Observation.liked_back(current_dog.id).map(&:dog_id)
    match_ids = likes.select { |like| liked.include?(like)}
    @matches = Dog.where(id: match_ids)
  end
end
