# frozen_string_literal: true

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = FindEvents.new(policy_scope(Event)).call(permitted_params)
    authorize @events
  end

  def show
    @event = policy_scope(Event).find(params[:id])
    authorize @event
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event_user = @event.events_users.new(role: EventsUser.roles[:creator])
    @event_user.user = current_user
    authorize @event

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :event_description, :event_date, :route_id)
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def permitted_params
    params.permit(:search, :category)
  end
end
