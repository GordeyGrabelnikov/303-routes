# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday])
  end

  private

  def user_not_authorized
    redirect_to(request.referrer || root_path, notice: 'You are not authorized to perform this action.')
  end
end
