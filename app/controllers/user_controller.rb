class UserController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    check_identity(@user)
  end

  def edit
    @user = User.find(params[:id])
    check_identity(@user)
  end

  def update
    @user = User.find(params[:id])
    if current_user.id != @user.id
      flash[:notice] = "tsk, tsk, tsk"
    else
      @user.update_attributes(user_params)
    end

    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def check_identity(user)
    raise ActionController::RoutingError.new('Not Found') if user.id != current_user.id
  end
end
