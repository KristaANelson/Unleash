class ObservationsController < ApplicationController
  def new
    @observer = current_user.dogs.first
    @observed = Dog.find(rand(100))
    @observation = Observation.new
  end

  def create
    Observation.create(observation_params)
    redirect_to new_observation_path
  end

  private

  def observation_params
    params.require(:observation).permit(:observer_id, :observed_id, :liked)
  end
end
