# frozen_string_literal: true

class EventsUsersController < ApplicationController
  def create
    @event_user = ::EventsUsers::Create.call(@event.id, current_user.id)

    redirect_to @event, notice: 'You successfully subscribed' if @event.save
  end

  def destroy
    EventsUsers::Destroy.call(@event.id, current_user.id)
  end
end
