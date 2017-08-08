class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: { users: users }
  end

  def show
    user = User.find_by(id: params[:id])
    render json: { user: user }
  end
end
