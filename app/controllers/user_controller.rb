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

  def add_user_to_group
    user_to_invite = params[:user_email]
    group_to_add = Group.find(params[:group_id])

    existing_user = User.find_by email: user_to_invite

    if existing_user
      action = "added"
      existing_user.groups << group_to_add
    else
      action = "invited"
      User.invite!(email: user_to_invite, invited_group_id: group_to_add.id)
    end

    flash[:notice] = "The user was #{action} successfully."
    redirect_to group_path(group_to_add)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def check_identity(user)
    raise ActionController::RoutingError.new('Not Found') if user.id != current_user.id
  end
end
