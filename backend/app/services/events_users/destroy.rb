# frozen_string_literal: true

module EventsUsers
  class Destroy < BaseServiceObject
    param :event
    param :user

    def call
      @event_user = EventsUser.where(event_id: event.id, user_id: user.id).first
      if @event_user.role == 'creator'
        event.destroy
      else
        @event_user.destroy
        event
      end
    end
  end
end
