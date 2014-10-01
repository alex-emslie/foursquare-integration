class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    check_for_association(@user) unless @user == current_user
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
      existing_user.groups << group_to_add unless existing_user.groups.include?(group_to_add)
    else
      action = "invited"
      User.invite!(email: user_to_invite, invited_group_id: group_to_add.id)
    end

    flash[:notice] = "The user was #{action} successfully."
    redirect_to group_path(group_to_add)
  end

  def leave_group
    group_to_leave = params[:group_id]
    current_user.groups.delete(group_to_leave)
    flash[:notice] = "successfully left group"
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, interests_attributes: [:interest_type, :details, :sentiment, :user_id])
  end

  def check_identity(user)
    raise ActionController::RoutingError.new('Not Found') if user.id != current_user.id
  end

  def check_for_association(user)
    possible_associations = []
    user.groups.each do |group|
      possible_associations << group.users.pluck('id')
    end

    raise ActionController::RoutingError.new('Not Found') unless possible_associations.flatten!.include?(current_user.id)
  end
end
