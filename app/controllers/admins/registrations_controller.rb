
class Admins::RegistrationsController < Devise::RegistrationsController
  # disable default no_authentication action
  skip_before_action :require_no_authentication, only: [:new, :create, :cancel]
  # now we need admin to register new admin
  prepend_before_action :authenticate_super_admin!, only: [:new, :create, :cancel]

  protected

  def sign_up(resource_name, resoure)
    # just overwrite the default one
    # to prevent auto sign in as the new sign up
  end

  def authenticate_super_admin!
    authenticate_scope!

    unless resource.super_admin?
      redirect_to root_path
    end
  end
end