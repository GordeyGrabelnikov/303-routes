class RaterController < ApplicationController

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]


      # redirect_to obj
      render :json => true
    else
      # redirect_to obj
      render :json => false
    end
  end
end
