# frozen_string_literal: true

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_event, only: %i[show edit update destroy update_event_status follow unfollow]

  def index
    @events = SearchResources::SearchEvents.new(policy_scope(Event)).call(permitted_params)
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
    @event = Events::Create.call(current_user, event_params)
    authorize @event

    if @event
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

  def update_event_status
    PublishService.new(@event, :event).activated
    redirect_to events_path
  end

  def follow
    EventsUsers::Create.call(@event, current_user)
    redirect_to @event, notice: 'You successfully subscribed' if @event.save
  end

  def unfollow
    event = EventsUsers::Destroy.call(@event, current_user)
    if event
      redirect_to event
    else
      redirect_to events_path
    end
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
