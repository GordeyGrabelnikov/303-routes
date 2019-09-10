# frozen_string_literal: true

class PointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_point, only: %i[show edit update destroy]

  def index
    @points = policy_scope(Point)
    authorize @points
  end

  def show
    @point = policy_scope(Point).find(params[:id])
    authorize @point
  end

  def new
    @point = Point.new
    authorize @point
  end

  def create
    @point = Point.new(point_params)
    authorize @point

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

  private

  def point_params
    params.require(:point).permit(:name, :description, :tags, :coordinates, images: [])
  end

  def set_point
    @point = Point.find(params[:id])
    authorize @point
  end
end
