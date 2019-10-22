# frozen_string_literal: true

module EventsUsers
  class Create < BaseServiceObject
    param :event_id
    param :user_id

    option :role, default: -> { :follower }

    def call
      events_user.save
      events_user
    end

    private

    def events_user
      @events_user ||= EventsUser.new(event_id: event_id, user_id: user_id, role: role)
    end
  end
end
