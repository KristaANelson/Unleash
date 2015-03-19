class SearchPreferencesController < ApplicationController
  def new
    @search_preference = SearchPreference.new
  end

  def create
    search = SearchPreference.create(search_params)
    if current_user.dogs.count > 1
      redirect_to new_observation_path
    else
      redirect_to observations_path
    end
  end

  def edit
    @search_preference = current_dog.search_preference
  end

  def update
    current_dog.search_preference.update_attributes(search_params)
    redirect_to new_observation_path
  end

  private

  def search_params
    params.require(:search_preference).permit(:dog_id,
                                              :distance,
                                              :ages   => [],
                                              :sizes  => [],
                                              :gender => [],
                                              :breeds => [])
    .each {|k,v| v.reject!(&:empty?) if v.class == Array }
  end
end
