class DogsController < ApplicationController
  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.img = params[:dog][:img].tempfile if params[:dog][:img]
    if @dog.save
      @current_dog = @dog
      redirect_to new_search_preference_path
    else
      render :new
    end
  end

  def index
  end

  private

  def dog_params
    params.require(:dog).permit(:name,
                                :age,
                                :size,
                                :gender,
                                :breed,
                                :zipcode,
                                :images,
                                :user_id)
  end
end
