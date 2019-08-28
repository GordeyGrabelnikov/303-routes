class Points::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Point.find(params[:point_id])
  end
end