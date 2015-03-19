class ObservationsController < ApplicationController
  def new
    @observed = Dog.filters(current_dog.id).first
    @observation = Observation.new
  end

  def create
    Observation.create(observation_params)
    redirect_to new_observation_path
  end

  def index
  end

  private

  def observation_params
    params.require(:observation).permit(:observer_id,
                                        :observed_id,
                                        :liked,
                                        :distance)
  end
end
