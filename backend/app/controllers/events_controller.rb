# frozen_string_literal: true

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_event, only: %i[show edit update destroy update_event_status follow unfollow]
  before_action :authorize_event, only: %i[create index new]

  def index
    @events = Events::Search.call(policy_scope(Event), permitted_params.to_h)
  end

  def show
    @event = policy_scope(Event).find(params[:id])
  end

  def new
    @event = Event.new(route_id: params[:route_id])
  end

  def create
    Events::Create.new.call(user_id: current_user.id,
                            event_params: event_params,
                            guide_id: params[:event][:guide_id]) do |f|
      f.failure do |error|
        redirect_to events_path, alert: error.to_s
      end

      f.success do |event|
        redirect_to event
      end
    end
  end

  def edit; end

  def update
    Events::Update.new.call(event: @event,
                            event_params: event_params,
                            guide_id: params[:event][:guide_id]) do |f|
      f.failure do |error|
        redirect_to event_path, alert: error.to_s
      end

      f.success do |event|
        redirect_to event
      end
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def update_event_status
    Events::Publish.call(@event)
    redirect_to events_path
  end

  def follow
    EventsUsers::Create.call(@event.id, current_user.id)
    redirect_to @event, notice: 'You successfully subscribed'
  end

  def unfollow
    event = EventsUsers::Destroy.call(@event.id, current_user.id)
    if event
      redirect_to event
    else
      redirect_to events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date, :route_id)
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def authorize_event
    authorize Event
  end

  def permitted_params
    params.permit(:search, :category)
  end
end
