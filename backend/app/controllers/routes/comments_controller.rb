# frozen_string_literal: true

class Routes::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Route.find(params[:route_id])
  end
end
