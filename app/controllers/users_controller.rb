class UsersController < ApplicationController
  def show
    @dog = current_user.dogs.first
  end
end
