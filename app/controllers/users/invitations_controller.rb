class Users::InvitationsController < Devise::InvitationsController
  def edit
    resource.invitation_token = params[:invitation_token]
    @group_to_add = params[:group_id]
    render :edit
  end

    # PUT /resource/invitation
  def update
    self.resource = accept_resource
    resource.groups << Group.find(params[:group_to_add])
    if resource.errors.empty?
      yield resource if block_given?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message if is_flashing_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end
end
