class DogsController < ApplicationController
  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.img = params[:dog][:images][:img].tempfile
    if @dog.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :age, :weight, :gender, :breed, :street, :city, :state, :zipcode, :images, :user_id)
  end
end
