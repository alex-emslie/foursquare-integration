class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save
    current_user.groups << @group
    redirect_to @group
  end

  def show
    @group = Group.find(params[:id])
    check_group_membership(@group)
  end

  def edit
    @group = Group.find(params[:id])
    check_group_membership(@group)
  end

  def update
    @group = Group.find(params[:id])
    check_group_membership(@group)

    @group.update_attributes(group_params)
    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :picture)
  end

  def check_group_membership(group)
    raise ActionController::RoutingError.new('Not Found') unless current_user.groups.include?(group)
  end
end
