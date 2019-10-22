# frozen_string_literal: true

class RaterController < ApplicationController
  before_action :fetch_current_category

  def create
    if user_signed_in?
      @obj.rate params[:score].to_f, current_user, params[:dimension]

      # redirect_to obj
      render json: true
    else
      # redirect_to obj
      render json: false
    end
  end

  private

  def fetch_current_category
    @obj = params[:klass].classify.constantize.find(params[:id])
  end
end
