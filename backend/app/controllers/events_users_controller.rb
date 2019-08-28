class EventsUsersController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @event_user = @event.events_users.new
    @event_user.user = current_user
    redirect_to @event, notice: 'You successfully subscribed' if @event.save
  end

  def destroy
    @event_user = EventsUser.find(params[:event_id])
    if @event_user.role == 'creator'
      Event.find(params[:id]).destroy
      redirect_to events_path
    else
      @event_user.destroy
      redirect_to event_path
    end
  end
end