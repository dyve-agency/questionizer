class Users::RegistrationsController < Devise::RegistrationsController
  layout :set_layout

  # before_filter :force_https
  before_filter :configure_permitted_parameters

  private

  def set_layout
    case action_name
    when 'edit', 'update' then "dashboard"
    else 'public'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        # :terms_of_service,
        :password,
        :password_confirmation,
        :email,
        # :name,
        )
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        # :terms_of_service,
        :password,
        :password_confirmation,
        :email,
        # :name,
        )
    end
  end
end
