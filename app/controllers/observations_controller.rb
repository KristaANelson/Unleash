class ObservationsController < ApplicationController
  def new
    redirect_to dog_path(current_dog) if Dog.apply_filters(current_dog).empty?
    @observed = Dog.apply_filters(current_dog)[0]
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
