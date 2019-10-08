# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name birthday avatar])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday, :avatar])
  end

  private

  def user_not_authorized
    redirect_to(request.referer || root_path, notice: t('notice.messages.not_enough_rights'))
  end
end
