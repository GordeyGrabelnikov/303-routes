# frozen_string_literal: true

class RoutesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_route, only: %i[edit update destroy]

  def index
    @routes = policy_scope(Route)
    authorize @routes
  end

  def show
  @route = policy_scope(Route).find(params[:id])
  authorize @route
  end

  def new
    @route = Route.new
    @route.points_routes.build
    authorize @route
  end

  def create
    @route = Route.new(route_params)
    @route.user = current_user
    authorize @route


    if @route.save
      redirect_to @route
    else
      render :new
    end
  end

  def edit; end

  def update
    if @route.update(route_params)
      redirect_to @route
    else
      render :edit
    end
  end

  def destroy
    @route.destroy
    redirect_to routes_path
  end

  private

  def route_params
    params.require(:route).permit(:name, :route_type, route_images: [], point_ids: [])
  end

  def set_route
    @route = Route.find(params[:id])
    authorize @route
  end
end
