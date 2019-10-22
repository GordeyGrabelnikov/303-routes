# frozen_string_literal: true

class PointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_point, only: %i[show edit update destroy update_point_status]
  before_action :authorize_point, only: %i[create index new]

  def index
    @points = Points::Search.call(policy_scope(Point), permitted_params.to_h)
  end

  def show
    @point = policy_scope(Point).find(params[:id])
  end

  def new
    @point = Point.new
  end

  def create
    @point = Point.new(point_params)
    @point.user = current_user

    if @point.save
      redirect_to @point
    else
      render :new
    end
  end

  def edit; end

  def update
    if @point.update(point_params)
      redirect_to @point
    else
      render :edit
    end
  end

  def destroy
    @point.destroy
    redirect_to points_path
  end

  def update_point_status
    Points::Publish.call(@point)
    redirect_to points_path
  end

  private

  def point_params
    params.require(:point).permit(:name, :description, :tags, :coordinates, images: [])
  end

  def set_point
    @point = Point.find(params[:id])
    authorize @point
  end

  def authorize_point
    authorize Point
  end

  def permitted_params
    params.permit(:search, :category)
  end
end
