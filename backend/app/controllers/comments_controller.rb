# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :load_commentable



  def create
    @comment = @commentable.comments.new(allowed_params)
    @comment.user = current_user
    @comment.save!
    redirect_back(fallback_location: root_path)
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def allowed_params
    params.require(:comment).permit(:comment)
  end

end