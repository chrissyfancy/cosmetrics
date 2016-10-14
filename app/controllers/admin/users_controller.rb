class Admin::UsersController < ApplicationController
  before_filter :authorize_admin!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if !@user
      flash[:notice] = "User successfully deleted."
      redirect_to admin_users_path
    else
      render :index
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :profile_photo, :password)
  end
end
