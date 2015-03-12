class DogsController < ApplicationController
  def new
    @dog = Dog.new
  end

  def index
    @dogs = Dog.all
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.img = params[:dog][:images][:img].tempfile
    if @dog.save
      redirect_to new_observation_path
    else
      render :new
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :age, :weight, :gender, :breed, :street, :city, :state, :zipcode, :images, :user_id)
  end
end
