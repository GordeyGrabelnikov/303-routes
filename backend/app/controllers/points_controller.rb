class PointsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_point, only: [:show, :edit, :update, :destroy]
  def index
    @points = Point.all
  end

  def show; end

  def new
    @point = Point.new
  end

  def create
    @point = Point.new(point_params)


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
    params.require(:point).permit(:name, :description, :tags, :coordinates, :image)
  end

  def set_point
    @point = Point.find(params[:id])
  end


end
