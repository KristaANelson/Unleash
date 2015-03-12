class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
    @dog = current_user.dogs.first
  end
end
