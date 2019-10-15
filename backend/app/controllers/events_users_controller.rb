# frozen_string_literal: true

class EventsUsersController < ApplicationController
  def create
    @event_user = ::EventsUsers::Create.call(@event, current_user)

    redirect_to @event, notice: 'You successfully subscribed' if @event.save
  end

  def destroy
    ::EventsUsers::Destroy.call(@event, current_user)
  end
end
