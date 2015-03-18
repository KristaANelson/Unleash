class ObservationsController < ApplicationController
  def new
    already_viewed = Observation.views(current_dog).map(&:observed_id) << current_dog.id
    @observed = Dog.where.not(id: already_viewed).shuffle.pop
    @observation = Observation.new
  end

  def create
    Observation.create(observation_params)
    if Observation.likes(observation_params[:observed_id]).map(&:observed_id).include?(current_dog.id)
      flash[:notice] = "Congrats! It's a match with #{Dog.find(observation_params[:observed_id]).name}"
    end
    redirect_to new_observation_path
  end

  private

  def observation_params
    params.require(:observation).permit(:dog_id, :observed_id, :liked)
  end
end
