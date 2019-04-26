class UsersController < ApplicationController

  def index
  end

  def new
  end

  def profile
    @user = User.find(params[:id])
  end

  def profile_update
    if current_user.update(user_profile_params)
      redirect_to user_path
    else
      redirect_to user_profile_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    redirect_to edit_user_path
  end

  def destroy

  end

  def show
    @user = User.find(params[:id])
  end

  def user_profile_params
    params.require(:user).permit(:nickname)
  end

end
