# frozen_string_literal: true

module EventsUsers
  class Destroy < BaseServiceObject
    param :event_id
    param :user_id

    def call
      @event_user = EventsUser.where(event_id: event_id, user_id: user_id).first
      if @event_user.creator?
        Event.destroy(event_id)
      else
        @event_user.destroy
        Event.where(id: event_id).first
      end
    end
  end
end
